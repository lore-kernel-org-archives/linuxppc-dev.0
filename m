Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D6E84DE242
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 00:20:58 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id m3MEKoBg170910
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 14:20:50 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m3MEKpec3514518
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 16:20:51 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m3MEKocT014504
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 16:20:50 +0200
Message-ID: <480DF46F.9090900@linux.vnet.ibm.com>
Date: Tue, 22 Apr 2008 16:21:35 +0200
From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: pci issue - wrong detection of pci ressources
References: <48088F02.2060806@linux.vnet.ibm.com>	<1208566122.6958.425.camel@pasglop>	<480BA937.7050603@linux.vnet.ibm.com>	<1208727408.7009.0.camel@pasglop>	<480C80B6.30904@linux.vnet.ibm.com>	<480C87BD.8090207@ru.mvista.com>	<480C9FE2.4030601@linux.vnet.ibm.com>
	<480CAFD2.2050108@ru.mvista.com> <480CBEE0.9000104@ru.mvista.com>
	<480DDE2B.4000808@linux.vnet.ibm.com>
	<480DE89B.2030402@ru.mvista.com>
In-Reply-To: <480DE89B.2030402@ru.mvista.com>
Content-Type: multipart/mixed; boundary="------------080102060607030908080205"
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080102060607030908080205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Sergei Shtylyov wrote:
> Hello.
> 
> Christian Ehrhardt wrote:
> 
[...]
> 
>> The Documentation of the 440EPx core lists these spaces:
>> PCI 1 Memory     1 8000 0000     1 BFFF FFFF     1GB
>> I/O              1 E800 0000     1 E800 FFFF     64KB
>> I/O              1 E880 0000     1 EBFF FFFF     56MB
> 
> Having 2 I/O spaces looks just wrong. Actually, PCs do well with only 
> 64K of I/O space.
> 

ok - I just wanted to be complete.
I removed the 56M section from the new dts file patch.

[...]

>> radeonfb: EDID probed
>> Parsing EDID data for panel info
>> Setting up default mode based on panel info
>> radeonfb (0000:00:0a.0): ATI Radeon Y`
> 
>    Hm, what's that Y`?

Thats the final message in the radeonfb driver ater initializing everything.
   printk ("radeonfb (%s): %s\n", pci_name(rinfo->pdev), rinfo->name);
I wonder why that rinfo->name is clobbered - maybe another issue, I have to keep that in mind.

[...]
> 
>    I think you'd better use Ben's patch that he's just posted:
> 
> http://patchwork.ozlabs.org/linuxppc/patch?id=18034
> 
> WBR, Sergei

yep - I use Ben's patch now which reduces my patch to the actual dts fix.
Updated patch attached.

-- 

Grüsse / regards, 
Christian Ehrhardt
IBM Linux Technology Center, Open Virtualization

--------------080102060607030908080205
Content-Type: text/plain;
 name="fix-sequoia-pci-memory-dts"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-sequoia-pci-memory-dts"

Subject: [PATCH][dts]: fix pci mem in sequoia dts

From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>

This patch is fixing the sequoia.dts device tree file to the values defined
in the 440Epx data sheet from amcc.
That fixes an issue where my graphic card could not initialize because the pci
resource space was not big enough.
The related mail thread about the backgrounds of this has the subject "pci
issue - wrong detection of pci ressources"

Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
---

[diffstat]
 sequoia.dts |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequoia.dts
--- a/arch/powerpc/boot/dts/sequoia.dts
+++ b/arch/powerpc/boot/dts/sequoia.dts
@@ -344,9 +344,13 @@
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed. Chip supports a second
 			 * IO range but we don't use it for now
+			 * From the 440EPx user manual:
+			 * PCI 1 Memory     1 8000 0000     1 BFFF FFFF     1GB
+			 * I/O              1 E800 0000     1 E800 FFFF     64KB
+			 * I/O              1 E880 0000     1 EBFF FFFF     56MB
 			 */
-			ranges = <02000000 0 80000000 1 80000000 0 10000000
-				01000000 0 00000000 1 e8000000 0 00100000>;
+			ranges = <02000000 0 80000000 1 80000000 0 40000000
+				01000000 0 00000000 1 e8000000 0 00010000>;
 
 			/* Inbound 2GB range starting at 0 */
 			dma-ranges = <42000000 0 0 0 0 0 80000000>;

--------------080102060607030908080205--
