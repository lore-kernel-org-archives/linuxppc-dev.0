Return-Path: <lk.atwork@yahoo.com>
Received: from n56.bullet.mail.sp1.yahoo.com (n56.bullet.mail.sp1.yahoo.com
	[98.136.44.52]) by ozlabs.org (Postfix) with SMTP id 33A0EDE05A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Sep 2008 11:36:22 +1000 (EST)
Date: Thu, 4 Sep 2008 18:36:20 -0700 (PDT)
From: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Subject: UPM setup
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1538437340-1220578580=:11205"
Message-ID: <151111.11205.qm@web46307.mail.sp1.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1538437340-1220578580=:11205
Content-Type: text/plain; charset=us-ascii

Hi,

I'm trying to set up the UPM RAM table for NAND access.
Here is how I do it:

        char __iomem *lbc_addr;
        int i;

        lbc_addr = ioremap(0xa0000000, 0x10);

        /* NAND chip (256MB) will be driven by UPM-A at LBC address 0xa0000000 */
        out_be32(&fsl_lbc_regs->bank[4].br, 0xa0000881);
        out_be32(&fsl_lbc_regs->bank[4].or, 0xf0000001);

        /* setup MAMR for sequential write to UPM-A RAM */
        out_be32(&fsl_lbc_regs->mamr, 0x10000000);

        for (i = 0; i < 64; i++) {
                out_be32(&fsl_lbc_regs->mdr, UPMATable[i]);
                out_8(lbc_addr, 0);   /* dummy write, byte wide */
        }

        /* restore MAMR */
        out_be32(&fsl_lbc_regs->mamr, 0x00000000);

But this does not seem to be working. I have verified this in two ways

a) for each write to mdr in the for loop above, I read back mamr and print it. This should have an incrementing
MAD value, but it does not

b) I read back the data that I had stored in UPM-A RAM and that logic does not work either.

My take is that out_8(lbc_addr, 0) is not working because I'm not mapping lbc_addr correctly.
Can someone tell me what I'm doing wrong?

thanks for your help
LK


      
--0-1538437340-1220578580=:11205
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><div>Hi,<br><br>I'm trying to set up the UPM RAM table for NAND access.<br>Here is how I do it:<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char __iomem *lbc_addr;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lbc_addr = ioremap(0xa0000000, 0x10);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* NAND chip (256MB) will be driven by UPM-A at LBC address 0xa0000000 */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be32(&amp;fsl_lbc_regs-&gt;bank[4].br, 0xa0000881);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be32(&amp;fsl_lbc_regs-&gt;bank[4].or, 0xf0000001);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* setup MAMR for sequential write to UPM-A RAM */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 out_be32(&amp;fsl_lbc_regs-&gt;mamr, 0x10000000);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; 64; i++) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be32(&amp;fsl_lbc_regs-&gt;mdr, UPMATable[i]);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_8(lbc_addr, 0);&nbsp;&nbsp; /* dummy write, byte wide */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* restore MAMR */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be32(&amp;fsl_lbc_regs-&gt;mamr, 0x00000000);<br><br>But this does not seem to be working. I have verified this in two ways<br><br>a) for each write to mdr in the for loop above, I read back mamr and print it. This should have an incrementing<br>MAD value, but it does not<br><br>b) I read back the data that I had stored in UPM-A RAM and that logic does not work
 either.<br><br>My take is that out_8(lbc_addr, 0) is not working because I'm not mapping lbc_addr correctly.<br>Can someone tell me what I'm doing wrong?<br><br>thanks for your help<br>LK<br><br></div></div><br>



      </body></html>
--0-1538437340-1220578580=:11205--
