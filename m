Date: Wed, 31 Mar 1999 20:39:53 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
Reply-To: Gabriel Paubert <paubert@iram.es>
To: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
cc: Paul.Mackerras@cs.anu.edu.au, bh40@calva.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Blue G3 and machine check
In-Reply-To: <19990401012034H.roikawa@rr.iij4u.or.jp>
Message-ID: <Pine.HPP.3.96.990331194357.1043L-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 1 Apr 1999, Ryuichi Oikawa wrote:

>  Though I'm not sure, do you mean for example something like below?
> 
> pmac_pci.c:
> __initfunc(unsigned long pmac_find_bridges(unsigned long mem_start, unsigned long mem_end))
> {
> 	int bus;
> 	struct bridge_data *bridge;
> +	struct device_node *p2pbridge;
> 
> 	bridge_list = 0;
> 	max_bus = 0;
> 	add_bridges(find_devices("bandit"), &mem_start);
> 	add_bridges(find_devices("chaos"), &mem_start);
> 	add_bridges(find_devices("pci"), &mem_start);
> 	bridges = (struct bridge_data **) mem_start;
> 	mem_start += (max_bus + 1) * sizeof(struct bridge_data *);
> 	memset(bridges, 0, (max_bus + 1) * sizeof(struct bridge_data *));
> 	for (bridge = bridge_list; bridge != NULL; bridge = bridge->next)
> 		for (bus = bridge->bus_number; bus <= bridge->max_bus; ++bus)
> 			bridges[bus] = bridge;
> 
> +	if((p2pbridge = find_devices("pci-bridge")) && !strcmp(p2pbridge->parent->name, "pci")) {
> +		unsigned char devfn;
> +		unsigned short val;
> +
> +		if(!pci_device_loc(p2pbridge, &bus, &devfn)) {
> +			grackle_pcibios_read_config_word(0, devfn, PCI_BRIDGE_CONTROL, &val);
> +			val &= ~PCI_BRIDGE_CTL_MASTER_ABORT;

Yes, this was along these lines. But I consider this more as a temporary
workaround than anything else. 

> Could you give me recommended/suggested fix codes on machine check
> exception? I think I can try them and report.

Can you first confirm that it is a machine check ? The code
is quite explicit in traps.c:

                switch( regs->msr & 0x0000F000)
                {
                case (1<<12) :
                        printk("Machine check signal - probably due to mm fault\n"
                                "with mmu off\n");
                        break;
                case (1<<13) :
                        printk("Transfer error ack signal\n");
                        break;
                case (1<<14) :
                        printk("Data parity signal\n");
                        break;
                case (1<<15) :
                        printk("Address parity signal\n");
                        break;
                default:
                        printk("Unknown values in msr\n");

If it is a machine check then you should modify the corresponding case
to handle a foreseen machine check. Note that earlier there is a comment
about MBX boards doing basically the same which is `handled' by simply
ignoring it.

Then how do you tell that the machine check is foreseen ? 

I was thinking about the possibility of setting a global flag (per
processor on SMP) saying that you are expecting a machine check:

- in every grackle_xxx set the flag, mb(), perform the access
  mb() again, clear the flag:

volatile int expect_machine_check = 0;

int grackle_pcibios_read_config_byte(unsigned char bus, unsigned char dev_fn,
				     unsigned char offset, unsigned char *val)
{
	struct bridge_data *bp;

	if (bus > max_bus || (bp = bridges[bus]) == 0)
		return PCIBIOS_DEVICE_NOT_FOUND;
	out_be32(bp->cfg_addr, GRACKLE_CFA(bus, dev_fn, offset));
+	expect_machine_check = 1;
+	mb();
	*val = in_8(bp->cfg_data + (offset & 3));
+	mb();
+	expect_machine_check = 0;	
	return PCIBIOS_SUCCESSFUL;
}
however this won't work because the SRR0 on the machine check might point
to the load instruction of in_8, leading to an infinite machine check
loop. So you have to go the harder way:

replacing the in_8 with something like:

asm volatile(
	"sync; "
"1: 	lbzx %0,%1,%2;"
"2:	sync;"
"3:	isync;"
"4:	;"
"	.section .fixup;"
"5:	li %0,-1;"
"	b 4b;"
"	.previous;"
"	.section __ex_table;"
"	.long 1b,5b,2b,5b,3b,5b;"	
"	.previous;" 
	: "r" (val) 
	: "b" (bp->cfg_data), "r" (offset & 3))
)
 
and I've still probably forgotten something. I would also like to know
at which instruction SRR0 points when we have a machine check. The
architecture description deliberately gives a lot of latitude to the chip
designers, it might even be necessary to perform some lengthy operation to
make sure that this works because the machine check might be delayed
enough clocks to let the processor proceed past the isync. 

Then you have to modify the machine check handler to use the fixup table
as in arch/ppc/mm/fault.c:

        /* Are we prepared to handle this fault?  */
        if ((fixup = search_exception_table(regs->nip)) != 0) {
                regs->nip = fixup;
                return;
        }

	

	Regards,
	Gabriel. 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
