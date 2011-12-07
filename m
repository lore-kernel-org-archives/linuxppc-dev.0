Return-Path: <B07421@freescale.com>
Message-ID: <4EDFD98A.4070803@freescale.com>
Date: Wed, 7 Dec 2011 15:24:26 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "Arshad, Farrukh" <Farrukh_Arshad@mentor.com>
Subject: Re: Multi-OS on P1022RDK Failing
References: <93CD5F41FDBC6042A6B449764F3B35CC050C38FB@EU-MBX-03.mgc.mentorg.com>
In-Reply-To: <93CD5F41FDBC6042A6B449764F3B35CC050C38FB@EU-MBX-03.mgc.mentorg.com>
Content-Type: text/plain; charset="windows-1252"
Cc: "Linuxppc-dev@lists.ozlabs.org" <Linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/07/2011 08:57 AM, Arshad, Farrukh wrote:
> Core 0 kernel
>=20
> CONFIG_LOWMEM_SIZE =3D 0x10000000
>=20
> CONFIG_PHYSICAL_START =3D 0x00000000
>=20
> =20
>=20
> Core 1 kernel
>=20
> CONFIG_LOWMEM_SIZE =3D 0x10000000
>=20
> CONFIG_PHYSICAL_START =3D 0x10000000

Why are you messing with CONFIG_LOWMEM_SIZE?  That adjusts the
lowmem/highmem split, not the total amount of memory that this instance
of Linux will use (though you may get that behavior as a side effect if
highmem is disabled).  U-boot should set the memory node in the device
tree based on the bootm_low/bootm_size environment variables.

> # Boot from NFS
>=20
> setenv core0nfsbootargs root=3D/dev/nfs nfsroot=3D$serverip:/$core0root=
fs
> ip=3D<dev_ip>::<nfs_server_ip>:::eth0:off rw debug
> console=3D$consoledev0,$baudrate maxcpus=3D1
>=20
> setenv core1nfsbootargs root=3D/dev/nfs nfsroot=3D$serverip:/$core1root=
fs
> ip=3D<dev_ip_2>::<nfs_server_ip>:::eth0:off rw debug
> console=3D$consoledev0,$baudrate maxcpus=3D1

maxcpus should be unnecessary -- there will only be one cpu in the
device tree for each partition.

> My problem is Core 0 kernel is booting successfully but Core 1 kernel
> hangs after uncompressing kernel image, and after that I don=92t see
> anything on the console.
>=20
> =20
>=20
> Any thoughts on what I am missing or doing incorrect?

The "cpu 1 release" command should be using the address of the
decompressed kernel (should be $bootm_low), not where the uImage was load=
ed.

Also, the two serial ports you're using share an interrupt -- this
shouldn't stop kernel message output, but it's going to be a problem for
userspace usage of the port.  You should remove the interrupts property
from the serial node in both partitions, so Linux will poll instead.

-Scott
