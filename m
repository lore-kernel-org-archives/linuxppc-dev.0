Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18490.22494.511244.977267@cargo.ozlabs.ibm.com>
Date: Mon, 26 May 2008 16:25:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: PReP residual to device-tree converter
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is a program that takes a PReP residual blob as input and
generates a device tree as output.  Currently the back-end uses printf
to output the tree in dts format, but it would be easy to do an
alternative back-end that outputs a dtb.  The idea is that this will
end up in the wrapper (with a dtb back-end), making it straightforward
to support PReP in arch/powerpc.

I would like people that have PReP machines to take a copy of
/proc/residual, run this program on it, and check that the output is
sane.  If it isn't, or if it is missing bits, send me the residual
blob with a description of what's wrong in the generated dts.  Since I
have only tested this with 2 blobs, both from IBM machines, it is very
likely that there are some assumptions in there that break on PRePs
from Motorola or other manufacturers.

To compile this program you'll need residual.h and pnp.h from
include/asm-ppc.  I found it easiest to create a symlink called "asm"
in the current directory, pointing to $kernelsource/include/asm-ppc,
and use -I. on the gcc command line.  Or you can copy residual.h and
pnp.h somewhere and munge the #include lines.

Paul.

#include <stdio.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <unistd.h>
#define __KERNEL__
#include <asm/residual.h>

RESIDUAL resid;

int indent;

void prindent(void)
{
	int i;

	for (i = 0; i < indent; ++i)
		printf("\t");
}

void start_node(const char *name)
{
	printf("\n");
	prindent();
	printf("%s {\n", name);
	++indent;
}

void end_node(void)
{
	--indent;
	prindent();
	printf("};\n");
}

void strprop(const char *name, const char *val)
{
	prindent();
	printf("%s = \"%s\";\n", name, val);
}

void strnprop(const char *name, const unsigned char *val, int len)
{
	prindent();
	printf("%s = \"%.*s\";\n", name, len, val);
}

void multistrprop(const char *name, int n, ...)
{
	int i;
	va_list args;
	const char *sep = "=";
	const char *p;

	prindent();
	printf("%s ", name);
	va_start(args, n);
	for (i = 0; i < n; ++i) {
		p = va_arg(args, const char *);
		if (p) {
			printf("%s \"%s\"", sep, p);
			sep = ",";
		}
	}
	va_end(args);
	printf(";\n");
}

void intprop(const char *name, int val)
{
	prindent();
	printf("%s = <%d>;\n", name, val);
}

void voidprop(const char *name)
{
	prindent();
	printf("%s;\n", name);
}

void bufprop(const char *name, unsigned int *buf, int ncells, int npl)
{
	const char *sep = "<";
	int i, l = 0;

	prindent();
	printf("%s = ", name);
	for (i = 0; i < ncells; ++i) {
		if (l++ == npl) {
			printf("\n");
			prindent();
			printf("\t");
			l = 1;
		}
		printf("%s0x%x", sep, buf[i]);
		sep = " ";
	}
	printf(">;\n");
}

const char *cpu_states[] = {
	"okay", "disabled", "fail-off", "fail"
};

struct pvr_table {
	unsigned int mask, value;
	const char *name;
} pvr_table[] = {
	{ 0xffff0000, 0x00010000, "PowerPC,601" },
	{ 0xffff0000, 0x00030000, "PowerPC,603" },
	{ 0xffff0000, 0x00040000, "PowerPC,604" },
	{ 0xffff0000, 0x00060000, "PowerPC,603e" },
	{ 0xffff0000, 0x00070000, "PowerPC,603ev" },
	{ 0xffff0000, 0x00080000, "PowerPC,750" },
	{ 0xfffff000, 0x00090000, "PowerPC,604e" },
	{ 0xffff0000, 0x00090000, "PowerPC,604r" },
	{ 0xffff0000, 0x000a0000, "PowerPC,604ev" },
	{ 0xffff0000, 0x000c0000, "PowerPC,7400" },
	{ 0xffff0000, 0x80000000, "PowerPC,7450" },
	{ 0xffff0000, 0x80010000, "PowerPC,7455" },
	{ 0xffff0000, 0x80020000, "PowerPC,7447" },
	{ 0xffff0000, 0x80030000, "PowerPC,7447A" },
	{ 0xffff0000, 0x80040000, "PowerPC,7448" },
	{ 0xffff0000, 0x800c0000, "PowerPC,7410" },
	{ 0, 0, "PowerPC" }
};

const char *match_pvr(unsigned int pvr)
{
	struct pvr_table *p;

	for (p = pvr_table; (pvr & p->mask) != p->value; ++p)
		;
	return p->name;
}

#define getw(p)	((p)[0] + ((p)[1] << 8))
#define getl(p)	((p)[0] + ((p)[1] << 8) + ((p)[2] << 16) + ((p)[3] << 24))

PPC_DEVICE *find_dev(PnP_BASE_TYPE basetype, PnP_SUB_TYPE subtype,
		     int intf, PPC_DEVICE *last)
{
	int i = 0;

	if (last != NULL)
		i = (last - resid.Devices) + 1;
	for (; i < resid.ActualNumDevices; ++i)
		if (resid.Devices[i].DeviceId.BaseType == basetype &&
		    resid.Devices[i].DeviceId.SubType == subtype &&
		    (intf < 0 || resid.Devices[i].DeviceId.Interface == intf))
			return &resid.Devices[i];
	return NULL;
}

unsigned char *find_pnp(int *offsetp, int tag, int minlen, int byte0,
			int *lenp)
{
	unsigned char *p = &resid.DevicePnPHeap[*offsetp];
	int nb, t;

	for (;;) {
		t = *p++;
		if (!(t & 0x80)) {
			nb = t & 7;
			t >>= 3;
		} else {
			nb = getw(p);
			p += 2;
		}
		if (t == tag && nb >= minlen && (byte0 < 0 || p[0] == byte0)) {
			*offsetp = p - resid.DevicePnPHeap + nb;
			if (lenp)
				*lenp = nb;
			return p;
		}
		if (t == EndTag)
			return NULL;
		p += nb;
	}
}

void decode3(char *buf, unsigned int vendor)
{
	buf[0] = '@' + ((vendor >> 10) & 0x1f);
	buf[1] = '@' + ((vendor >> 5) & 0x1f);
	buf[2] = '@' + (vendor & 0x1f);
}

char *decode_chipid(unsigned char *p)
{
	static char buf[8];
	int vendor = (p[1] << 8) + p[2];
	int devid = (p[3] << 8) + p[4];

	decode3(buf, vendor);
	sprintf(&buf[3], "%.4X", devid);
	return buf;
}

#define VPD	resid.VitalProductData

#define i8259_phandle	0x3ffff
#define mpic_phandle	0x40000

unsigned int buf[2048];

void do_pci_bus(unsigned int);

void do_model(PPC_DEVICE *dev)
{
	int offset;
	unsigned char *p;

	offset = dev->AllocatedOffset;
	p = find_pnp(&offset, SmallVendorItem, 5, 1, NULL);
	if (p)
		strprop("model", decode_chipid(p));
}

unsigned int find_8259_ack_addr(void)
{
	PPC_DEVICE *dev;
	int offset;
	unsigned char *p;

	dev = find_dev(SystemPeripheral, ProgrammableInterruptController,
		       ISA_PIC, NULL);
	if (!dev)
		return 0;
	offset = dev->AllocatedOffset;
	while ((p = find_pnp(&offset, L4_Packet, 21, 9, NULL)) != NULL)
		if (p[1] == 3 && p[2] == 32)
			return getl(p + 5);
	return 0;
}

int make_isa_reg(PPC_DEVICE *dev)
{
	int offset, i = 0;
	unsigned char *p;
	unsigned int space;

	/* Look for Address tags */
	offset = dev->AllocatedOffset;
	while ((p = find_pnp(&offset, L4_Packet, 21, 9, NULL)) != NULL) {
		if (p[1] == 1) {
			if (p[2] <= 10)
				space = 3;
			else if (p[2] == 11)
				space = 5;
			else
				space = 1;
		} else if (p[1] == 2) {
			space = 0;
		} else
			continue;
		buf[i++] = space;
		buf[i++] = getl(p + 5);
		buf[i++] = getl(p + 13);
	}

	/* Look for IOPort tags */
	offset = dev->AllocatedOffset;
	while ((p = find_pnp(&offset, IOPort, 7, 1, NULL)) != NULL) {
		buf[i++] = 1;
		buf[i++] = getw(p + 1);
		buf[i++] = p[6];
	}

	return i;
}

void do_pci_addresses(PPC_DEVICE *dev)
{
	int offset, i = 0;
	unsigned char *p;
	unsigned int bar;

	bar = (dev->BusAccess.PCIAccess.BusNumber << 16) |
		(dev->BusAccess.PCIAccess.DevFuncNumber << 8) | 0x80000010u;
	/* Look for Address tags */
	offset = dev->AllocatedOffset;
	while ((p = find_pnp(&offset, L4_Packet, 21, 9, NULL)) != NULL) {
		if (p[1] == 1 || p[1] == 2) {
			buf[i++] = bar + (p[1] << 24);
			buf[i++] = getl(p + 9);
			buf[i++] = getl(p + 5);
			buf[i++] = getl(p + 17);
			buf[i++] = getl(p + 13);
			bar += 4;
		}
	}
	if (i > 0)
		bufprop("assigned-addresses", buf, i, 5);
}

const char *isa_space_tag[] = { "m", "i" };

static int seen_8042;

void do_isa_dev(PPC_DEVICE *dev)
{
	int offset, i, j;
	unsigned char *p;
	char name[32];
	char pnp[12];
	const char *type, *compat;
	int is_8259 = 0;
	unsigned int mask;

	strcpy(pnp, "pnp");
	decode3(pnp + 3, dev->DeviceId.DevId >> 16);
	sprintf(pnp + 6, ",%lX", dev->DeviceId.DevId & 0xffff);
	type = pnp;
	compat = NULL;
	switch (dev->DeviceId.BaseType) {
	case MassStorageDevice:
		switch (dev->DeviceId.SubType) {
		case IDEController:
			type = "ide";
			break;
		case FloppyController:
			type = "fdc";
			break;
		}
		break;
	case MultimediaController:
		switch (dev->DeviceId.SubType) {
		case AudioController:
			type = "sound";
			break;
		}
		break;
	case CommunicationsDevice:
		switch (dev->DeviceId.SubType) {
		case RS232Device:
			type = "serial";
			break;
		case ATCompatibleParallelPort:
			type = "parallel";
			break;
		}
		break;
	case SystemPeripheral:
		switch (dev->DeviceId.SubType) {
		case ProgrammableInterruptController:
			type = "interrupt-controller";
			if (dev->DeviceId.Interface == ISA_PIC) {
				is_8259 = 1;
				compat = "chrp,iic";
			}
			break;
		case DMAController:
			type = "dma-controller";
			break;
		case SystemTimer:
			type = "timer";
			break;
		case RealTimeClock:
			type = "rtc";
			break;
		case L2Cache:
			type = "cache-controller";
			break;
		case NVRAM:
			type = "nvram";
			break;
		case PowerManagement:
			type = "IBM,pwr-mgmt";
			break;
		case OperatorPanel:
			type = "IBM,op-panel";
			break;
		}
		break;
	case InputDevice:
		switch (dev->DeviceId.SubType) {
		case KeyboardController:
		case MouseController:
			if (seen_8042)
				return;
			seen_8042 = 1;
			type = "8042";
			compat = "chrp,8042";
			break;
		case TabletController:
			type = "IBM,tablet-port";
			break;
		}
		break;
	}

	i = make_isa_reg(dev);
	if (!i)
		return;

	sprintf(name, "%s@%s%x", type, isa_space_tag[buf[0] & 1], buf[1]);
	start_node(name);

	bufprop("reg", buf, i, 6);

	multistrprop("compatible", 2, compat, pnp);
	do_model(dev);

	if (is_8259) {
		voidprop("interrupt-controller");
		intprop("#interrupt-cells", 2);
		buf[0] = i8259_phandle;
		bufprop("linux,phandle", buf, 1, 1);
		if (find_dev(SystemPeripheral, ProgrammableInterruptController,
			     MPIC, NULL)) {
			/* hard-code cascade to mpic interrupt 0 */
			buf[0] = mpic_phandle;
			bufprop("interrupt-parent", buf, 1, 1);
			buf[0] = 0;
			buf[1] = 2;
			bufprop("interrupts", buf, 2, 2);
		}

	} else {
		/* look for interrupts */
		i = 0;
		offset = dev->AllocatedOffset;
		while ((p = find_pnp(&offset, IRQFormat, 2, -1, NULL))) {
			mask = getw(p);
			for (j = 0; mask != 0; ++j, mask >>= 1)
				if (mask & 1) {
					buf[i++] = j;
					buf[i++] = 3;
				}
		}
		if (i > 0)
			bufprop("interrupts", buf, i, 4);
	}

	end_node();
}

unsigned int do_pci_bridge(PPC_DEVICE *pci)
{
	int offset, i, j, len;
	unsigned int bus = 0;
	unsigned char *p;
	unsigned int irq_parent, irq, irq_sense;

	/* find PCI bridge info */
	offset = pci->AllocatedOffset;
	p = find_pnp(&offset, L4_Packet, 21, 3, &len);
	if (!p)
		return 0;

	bus = getl(p + 17);
	/* generate interrupt-map and mask by iterating over slots */
	i = 0;
	p += 21;
	for (len -= 21; len >= 12; len -= 12, p += 12) {
		if (p[2] == 1) {
			irq_parent = i8259_phandle;
			irq_sense = 3;	/* XXX ? */
		} else if (p[2] == 2) {
			irq_parent = mpic_phandle;
			irq_sense = 2;
		} else
			continue;
		for (j = 0; j < 4; ++j) {
			irq = getw(p + 4 + 2*j);
			if (irq == 0xffff)
				continue;
			buf[i++] = p[1] << 8;	/* devfn */
			buf[i++] = 0;
			buf[i++] = 0;
			buf[i++] = j;
			buf[i++] = irq_parent;
			buf[i++] = irq;
			buf[i++] = irq_sense;
		}
	}
	if (i > 0) {
		bufprop("interrupt-map", buf, i, 7);
		buf[0] = 0xf800;
		buf[1] = 0;
		buf[2] = 0;
		buf[3] = 7;
		bufprop("interrupt-map-mask", buf, 4, 4);
	}

	return bus;
}

void do_pci_dev(PPC_DEVICE *dev)
{
	int i;
	unsigned int bus;
	char str[16];
	const char *name;
	int devfn = dev->BusAccess.PCIAccess.DevFuncNumber;
	unsigned int pciloc;

	/* construct a minimal reg property */
	i = 0;
	pciloc = (dev->BusAccess.PCIAccess.BusNumber << 16) + (devfn << 8);
	buf[i++] = pciloc;
	buf[i++] = 0;
	buf[i++] = 0;
	buf[i++] = 0;
	buf[i++] = 0;

	/* see if it's something we care about */
	if (dev->DeviceId.BaseType == BridgeController &&
	    dev->DeviceId.SubType == ISABridge)
		name = "isa";
	else if (dev->DeviceId.BaseType == BridgeController &&
		 dev->DeviceId.SubType == PCIBridge)
		name = "pci";
	else if (dev->DeviceId.BaseType == SystemPeripheral &&
		 dev->DeviceId.SubType == ProgrammableInterruptController &&
		 dev->DeviceId.Interface == MPIC) {
		name = "interrupt-controller";
		/* add an entry for BAR 0 so we can have assigned-addresses */
		buf[i++] = 0x02000010 | pciloc;
		buf[i++] = 0;
		buf[i++] = 0;
		buf[i++] = 0;
		buf[i++] = 0x40000;
	} else
		return;		/* ignore things we can probe */

	if (devfn & 7)
		sprintf(str, "%s@%x,%x", name, devfn >> 3, devfn & 7);
	else
		sprintf(str, "%s@%x", name, devfn >> 3);
	start_node(str);

	bufprop("reg", buf, i, 5);

	/* find chip ID */
	do_model(dev);

	if (strcmp(name, "pci") == 0) {
		strprop("device_type", "pci");
		bus = do_pci_bridge(dev);
		do_pci_bus(bus);
	} else if (strcmp(name, "isa") == 0) {
		buf[0] = i8259_phandle;
		bufprop("interrupt-parent", buf, 1, 1);
		for (i = 0; i < resid.ActualNumDevices; ++i)
			if (resid.Devices[i].DeviceId.BusId == ISADEVICE)
				do_isa_dev(&resid.Devices[i]);
			    
	} else {	/* must be interrupt-controller */
		voidprop("interrupt-controller");
		strprop("device_type", "open-pic");
		strprop("compatible", "chrp,open-pic");
		intprop("#interrupt-cells", 2);
		buf[0] = mpic_phandle;
		bufprop("linux,phandle", buf, 1, 1);
		do_pci_addresses(dev);
	}

	end_node();
}

void do_pci_bus(unsigned int bus)
{
	int j;

	for (j = 0; j < resid.ActualNumDevices; ++j)
		if (resid.Devices[j].DeviceId.BusId == PCIDEVICE &&
		    resid.Devices[j].BusAccess.PCIAccess.BusNumber == bus)
			do_pci_dev(&resid.Devices[j]);
}

void do_cpu(PPC_CPU *cpu, unsigned int tbfreq)
{
	PPC_DEVICE *l2;
	char num[20];
	int offset;
	unsigned char *p;

	if (cpu->CpuState > CPU_FAILED)
		return;
	sprintf(num, "%s@%x", match_pvr(cpu->CpuType), cpu->CpuNumber);
	start_node(num);
	strprop("device_type", "cpu");
	intprop("reg", cpu->CpuNumber);
	strprop("status", cpu_states[cpu->CpuState]);
	intprop("clock-frequency", VPD.ProcessorHz);
	intprop("timebase-frequency", tbfreq);
	intprop("bus-frequency", VPD.ProcessorBusHz);
	intprop("reservation-granule-size", VPD.GranuleSize);
	if (VPD.CacheAttrib == SplitCAC) {
		intprop("d-cache-size", VPD.D_CacheSize * 1024);
		intprop("d-cache-block-size", VPD.D_CacheLineSize);
		intprop("d-cache-line-size", VPD.D_CacheLineSize);
		intprop("d-cache-sets", VPD.D_CacheSize * 1024
			/ VPD.D_CacheLineSize / VPD.D_CacheAssoc);
		intprop("i-cache-size", VPD.I_CacheSize * 1024);
		intprop("i-cache-block-size", VPD.I_CacheLineSize);
		intprop("i-cache-line-size", VPD.I_CacheLineSize);
		intprop("i-cache-sets", VPD.I_CacheSize * 1024
			/ VPD.I_CacheLineSize / VPD.I_CacheAssoc);
	} else if (VPD.CacheAttrib == CombinedCAC) {
		voidprop("cache-unified");
		intprop("cache-size", VPD.CacheSize * 1024);
		intprop("cache-block-size", VPD.CacheLineSize);
		intprop("cache-line-size", VPD.CacheLineSize);
		intprop("cache-sets", VPD.CacheSize * 1024
			/ VPD.CacheLineSize / VPD.CacheAssoc);
	}
	if (VPD.TLBAttrib != NoneTLB) {
		intprop("tlb-size", VPD.TLBSize);
		intprop("tlb-sets", VPD.TLBSize / VPD.TLBAssoc);
		if (VPD.TLBAttrib == SplitTLB) {
			voidprop("tlb-split");
			intprop("d-tlb-size", VPD.D_TLBSize);
			intprop("d-tlb-sets",
				VPD.D_TLBSize / VPD.D_TLBAssoc);
			intprop("i-tlb-size", VPD.I_TLBSize);
			intprop("i-tlb-sets",
				VPD.I_TLBSize / VPD.I_TLBAssoc);
		}
	}
	l2 = find_dev(SystemPeripheral, L2Cache, -1, NULL);
	if (l2) {
		offset = l2->AllocatedOffset;
		p = find_pnp(&offset, L4_Packet, 13, 2, NULL);
		if (p) {
			unsigned int csize = getl(p + 1) * 1024;
			unsigned int assoc = getw(p + 5);
			unsigned int lsize = getw(p + 7);

			start_node("l2-cache");
			voidprop("cache-unified");
			intprop("d-cache-size", csize);
			intprop("d-cache-line-size", lsize);
			intprop("d-cache-sets", csize / lsize / assoc);
			intprop("i-cache-size", csize);
			intprop("i-cache-line-size", lsize);
			intprop("i-cache-sets", csize / lsize / assoc);
			end_node();
		}
	}
	end_node();
}

int main(int ac, char **av)
{
	int i, n, offset;
	int tbfreq, rem;
	unsigned char *p;
	PPC_DEVICE *pci;

	n = read(0, &resid, sizeof(resid));
	if (n < 0) {
		perror("read");
		exit(1);
	}
	if (n != resid.ResidualLength) {
		fprintf(stderr, "length error: read %d should be %lu\n",
			n, resid.ResidualLength);
		exit(1);
	}
	printf("/dts-v1/;\n");

	start_node("/");
	strnprop("model", VPD.PrintableModel, 32);
	strprop("compatible", "prep");
	intprop("#address-cells", 1);
	intprop("#size-cells", 1);
	strnprop("serial-number", VPD.Serial, 16);
	intprop("clock-frequency", VPD.ProcessorBusHz);

	start_node("chosen");
	end_node();

	start_node("cpus");
	intprop("#address-cells", 1);
	intprop("#size-cells", 0);
	tbfreq = (VPD.ProcessorBusHz / VPD.TimeBaseDivisor) * 1000;
	rem = VPD.ProcessorBusHz % VPD.TimeBaseDivisor;
	if (rem)
		tbfreq += (rem * 1000) / VPD.TimeBaseDivisor;
	for (i = 0; i < resid.MaxNumCpus; ++i)
		do_cpu(&resid.Cpus[i], tbfreq);
	end_node();

	start_node("memory@0");
	strprop("device_type", "memory");
	buf[0] = 0;
	buf[1] = resid.GoodMemory;	/* or TotalMemory? */
	bufprop("reg", buf, 2, 2);
	end_node();

	pci = NULL;
	while ((pci = find_dev(BridgeController, PCIBridge, -1, pci)) != NULL)
		if (pci->DeviceId.BusId == PROCESSORDEVICE)
			break;
	if (pci) {
		unsigned int bus;

		start_node("pci");
		strprop("device_type", "pci");
		strprop("compatible", "prep-pci");
		intprop("#address-cells", 3);
		intprop("#size-cells", 2);

		/* find chip ID */
		do_model(pci);

		bus = do_pci_bridge(pci);

		/* Generate ranges */
		i = 0;
		offset = pci->AllocatedOffset;
		while ((p = find_pnp(&offset, L4_Packet, 29, 5, NULL))) {
			unsigned int space;

			if (p[3] == 1)
				space = 2;	/* PCI memory */
			else if (p[3] == 2)
				space = 1;	/* PCI I/O */
			else
				continue;
			buf[i++] = space << 24;
			buf[i++] = getl(p + 17);	/* PCI address */
			buf[i++] = getl(p + 13);
			buf[i++] = getl(p + 5);		/* cpu address */
			buf[i++] = 0;
			buf[i++] = getl(p + 21);	/* size */
		}
		if (i > 0)
			bufprop("ranges", buf, i, 5);

		/* fake up a bus-range */
		buf[0] = bus;
		buf[1] = 0xff;
		bufprop("bus-range", buf, 2, 2);

		buf[0] = find_8259_ack_addr();
		if (buf[0])
			bufprop("8259-interrupt-acknowledge", buf, 1, 1);

		/* look for devices on this bus */
		do_pci_bus(bus);

		end_node();
	}

	end_node();

	if (indent)
		fprintf(stderr, "unbalanced: indent = %d\n", indent);
	exit(0);
}
