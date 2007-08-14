Return-Path: <mail4mz@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.189])
	by ozlabs.org (Postfix) with ESMTP id C62FEDDE2F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Aug 2007 06:21:59 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1287153rvf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Aug 2007 13:21:59 -0700 (PDT)
Message-ID: <5c9cd53b0708141321h62f0ddd1k3a57a37f52e93894@mail.gmail.com>
Date: Tue, 14 Aug 2007 16:21:58 -0400
From: "mike zheng" <mail4mz@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: System crash on boot_e500.S on 2.4Kernel
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4963_9241108.1187122918497"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_4963_9241108.1187122918497
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

  Hi All,

I am trying to bring up MPC8548 CDS board on 2.4 kernel. I have problem in
the head_e500.S. The "mtspr SRR0, r7; mtspr SRR1 r6" does not work for me.
The content of R7 and R6 are not moved to SRR0 and SRR1.  I am using the
tool-chain from Freescale for 2.6 kernel.

Any idea on this issue?

Thanks,

Mike



Code of head_e500.S:


      slwi  r6,r6,5      /* setup new context with other address space */
      bl    1f          /* Find our address */
1:    mflr  r9
      rlwimi      r7,r9,0,20,31
      addi  r7,r7,24
      mtspr SRR0,r7           ........No change in SRR0
      mtspr SRR1,r6           ........No change in SRR1
      rfi                     ........System crash

/* 4. Clear out PIDs & Search info */      l
      li    r6,0
      mtspr SPRN_PID0,r6
      mtspr SPRN_PID1,r6
      mtspr SPRN_PID2,r6
      mtspr SPRN_MAS6,r6

------=_Part_4963_9241108.1187122918497
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="ppt" id="_user_linuxppc-embedded@ozlabs.org"><span>&nbsp; 
<div style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span>Hi All,</span></font></font></div>
<div style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span></span></font></font>&nbsp;</div>
<div style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span>I&nbsp;am trying to bring&nbsp;up MPC8548 CDS board on 2.4 kernel.&nbsp;I have problem in the head_e500.S. The &quot;mtspr SRR0, r7; mtspr SRR1 r6&quot;&nbsp;does not work for me. The content of R7 and R6&nbsp;are not moved to SRR0 and&nbsp;SRR1.&nbsp; I am using the tool-chain from Freescale for 
2.6 kernel.&nbsp;</span></font></font></div>
<div style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span></span></font></font>&nbsp;</div>
<div style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span>Any idea on this&nbsp;issue?</span></font></font></div>
<div style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span></span></font></font>&nbsp;</div>
<div style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span>Thanks,</span></font></font></div>
<div style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span></span></font></font>&nbsp;</div>
<div style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span>Mike</span></font></font></div>
<div style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span></span></font></font>&nbsp;</div>
<div style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span></span></font></font>&nbsp;</div>
<div style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span></span></font></font>&nbsp;</div>
<div style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span>Code of head_e500.S:</span></font></font></div>
<div style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span></span></font></font>&nbsp;</div>
<div style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span>&nbsp;</span></font></font></div>
<div style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>slwi<span>&nbsp; </span><span></span>r6,r6,5<span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>/* setup new context with other address space */<br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>
bl<span>&nbsp;&nbsp;&nbsp; </span>1f<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>/* Find our address */ <br></font></font><font size="2"><font face="Courier New"><span lang="PT-BR">1:<span>&nbsp;&nbsp;&nbsp; </span>mflr<span>&nbsp; </span>r9<br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>rlwimi<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</span>r7,r9,0,20,31<br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>addi<span>&nbsp; </span>r7,r7,24<br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>mtspr<span> </span>SRR0,r7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ........No change in SRR0<br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>mtspr<span> </span>SRR1,r6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;........No&nbsp;change in SRR1 
<br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>rfi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ........System crash<br><br>/* 4. Clear out PIDs &amp; Search info */<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>l</font></font></div>
<div style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;li<span>&nbsp;&nbsp;&nbsp; </span>r6,0<br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>mtspr<span> </span>SPRN_PID0,r6<br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>mtspr<span> </span>SPRN_PID1,r6<br><span>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>mtspr<span> </span>SPRN_PID2,r6 <br><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>mtspr<span> </span>SPRN_MAS6,r6</font></font><br>&nbsp;</div></span></span>

------=_Part_4963_9241108.1187122918497--
