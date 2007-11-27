Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id D51BDDDE9B
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 04:18:25 +1100 (EST)
Message-ID: <474C49D5.2000206@ru.mvista.com>
Date: Tue, 27 Nov 2007 19:46:13 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 3/3] [POWERPC] MPC8349E-mITX: introduce localbus and pata
	nodes
References: <20071127153708.GA12490@localhost.localdomain>
	<20071127153940.GC14183@localhost.localdomain>
	<474C3C79.5060908@ru.mvista.com>
	<20071127164101.GA14790@localhost.localdomain>
In-Reply-To: <20071127164101.GA14790@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

>>>This patch adds localbus and pata nodes to use CF IDE interface
>>>on MPC8349E-mITX boards.

>>>Patch also adds code to probe localbus.

>>>Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>>>---
>>>arch/powerpc/boot/dts/mpc8349emitx.dts    |   17 ++++++++++++++++-
>>>arch/powerpc/platforms/83xx/mpc834x_itx.c |   17 +++++++++++++++++
>>>2 files changed, 33 insertions(+), 1 deletions(-)

>>>diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts 
>>>b/arch/powerpc/boot/dts/mpc8349emitx.dts
>>>index 5072f6d..7a97068 100644
>>>--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
>>>+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
>>>@@ -249,6 +249,21 @@
>>>		device_type = "pci";
>>>	};
>>>
>>>+	localbus@e0005000 {
>>>+		#address-cells = <2>;
>>>+		#size-cells = <1>;
>>>+		compatible = "fsl,mpc8349emitx-localbus",
>>
>>   Board compatible bus?

> This is what Documentation/powerpc/booting-without-of.txt suggests
> for localbuses. I'm following.

    Hm...

>>>+			     "fsl,mpc8349e-localbus",
>>>+			     "fsl,pq2pro-localbus";
>>>+		reg = <e0005000 d8>;
>>>+		ranges = <3 0 f0000000 210>;
>>>
>>>-
>>>+		pata@3,0 {
>>>+			compatible = "fsl,mpc8349emitx-pata", 
>>>"pata-platform";
>>>+			reg = <3 0 10 3 20c 4>;
>>>+			ioport-shift = <1>;

>>   Bleh... that shift again. And this is surely not a good name for a 
>>property (where's I/O ports in your case?) -- why not call it "reg-shift" 
>>(well, I'd call it "reg-size" or "reg-stride" myself :-)?

> 1. "shift" because pata_platform using that name. I don't see any
>    reason to contrive indirections. ioport-shift is what the whole
>    Linux kernel using nowadays, and ioport-shift dts property
>    anyway Linux-specific.

    It's just a bad name. There's not even I/O ports in this case (and 
moreover, the *real* I/O mapped device would always have a shift of 0, I bet 
-- larger strides are for memory mapped devices).

>    I'm just following todays' conventions.

>    If you feel really bad about that, I think better to fix that in
>    the source of the badness -- pata_platform. It's easy, I can do

    I only feel really bad about the "ioport" part, I can live with "shift" 
part. :-)

>    that. Would you ack patch that converts whole pata_platform and
>    users? Would Paul ack it?

    I don't understand -- why the property name should duplicate pata_platform 
field name? :-O

>    Still, is there any hardware that needs not power of 2 stride?

    Not really -- "size" just seems better, aesthetically. :-)

> 2. "ioport" because shift^Wstride ;-) applies only to the io range
>    (yes, it's obvious, but worth open-wording, no?).

    Contrarywise, to memory range.

> And btw, I can get rid of ioport-shift at all. And do fixups in
> the pata_of_platform driver via .compatible matching. But I don't
> want: it feels bad to list every needs-to-fixup board in the common
> driver. It also feels not so great creating something like
> pata-platform-stride-{1,2,4,...} compatible stuff. Heh.

    I didn't propose neither of that. :-)
    All I want is that "ioport-*" be renamed.

> Thanks,

MBR, Sergei
