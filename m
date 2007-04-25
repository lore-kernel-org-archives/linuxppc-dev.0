Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17966.45645.902486.793443@cargo.ozlabs.ibm.com>
Date: Wed, 25 Apr 2007 11:43:41 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/6] Consolidate of_find_property
In-Reply-To: <06c51eb59847d80d9225cd6454f1957e@kernel.crashing.org>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403223000.5d44b2f1.sfr@canb.auug.org.au>
	<20070403223136.6ecdabbd.sfr@canb.auug.org.au>
	<20070403223257.cb8c4d15.sfr@canb.auug.org.au>
	<20070403223535.dd6731d6.sfr@canb.auug.org.au>
	<20070403223738.03386a13.sfr@canb.auug.org.au>
	<20070403223914.35bf04e1.sfr@canb.auug.org.au>
	<20070403224039.913af749.sfr@canb.auug.org.au>
	<20070403224205.807cffe0.sfr@canb.auug.org.au>
	<20070403224340.5533abc9.sfr@canb.auug.org.au>
	<20070403224505.5d5a1495.sfr@canb.auug.org.au>
	<20070403224610.b61c7377.sfr@canb.auug.org.au>
	<20070403224937.f6a07e56.sfr@canb.auug.org.au>
	<20070403225059.e735b5e4.sfr@canb.auug.org.au>
	<20070403225222.88e92221.sfr@canb.auug.org.au>
	<20070403230505.f96ea210.sfr@canb.auug.org.au>
	<20070403232406.ab9a3c86.sfr@canb.auug.org.au>
	<20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070412153424.bf3957f4.sfr@canb.auug.org.au>
	<20070424223245.78f4fdfb.sfr@canb.auug.org.au>
	<20070424223930.1dab0e28.sfr@canb.auug .org.au>
	<06c51eb59847d80d9225cd6454f1957e@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	"David S. Miller" <davem@davemloft.net>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> Property names aren't supposed to contain uppercase
> characters. 

Somebody forgot to tell Apple:

$ ls /proc/device-tree/ht@0,f2000000/pci@9/ata-6@d
total 23
1 #address-cells             1 cable-type    1 interrupt-parent  1 name
1 #size-cells                1 class-code    1 interrupts        1 reg
1 AAPL,bus-id                1 compatible    0 lba-48            1 revision-id
1 AAPL,connector             1 device-id     1 linux,phandle     1 vendor-id
1 AAPL,pio-timing            1 device_type   1 max-latency
1 AAPL,requested-priorities  1 devsel-speed  1 min-grant
1 assigned-addresses         0 disk/         1 model

> I can swing both ways on which of strcmp()
> or strcasecmp() is better, but there seems no reason
> to do this differently on each platform.

The question is, what ppc drivers would break if we used strcmp
instead of strcasecmp?  I have a dim memory that some Apple machines
had "ata" and others had "ATA" for the hard disk, for instance.

Paul.
