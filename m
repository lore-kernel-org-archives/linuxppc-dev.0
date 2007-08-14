Return-Path: <mail4mz@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by ozlabs.org (Postfix) with ESMTP id 38D52DDE34
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 06:14:11 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1285757rvf
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 13:14:10 -0700 (PDT)
Message-ID: <5c9cd53b0708141314o57440c62waffb4cca3f2be0b9@mail.gmail.com>
Date: Tue, 14 Aug 2007 16:14:09 -0400
From: "mike zheng" <mail4mz@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: System crash on boot_e500.S
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4955_24118053.1187122449993"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_4955_24118053.1187122449993
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


      slwi  r6,r6,5     /* setup new context with other address space */
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

------=_Part_4955_24118053.1187122449993
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="ppt" id="_user_linuxppc-dev@ozlabs.org">
<div class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span style="mso-tab-count: 1">Hi All,</span></font></font></div>
<div class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span style="mso-tab-count: 1"></span></font></font>&nbsp;</div>
<div class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span style="mso-tab-count: 1">I&nbsp;am trying to bring&nbsp;up MPC8548 CDS board on 2.4 kernel.&nbsp;I have problem in the head_e500.S. The &quot;mtspr SRR0, r7; mtspr SRR1 r6&quot;&nbsp;does not work for me. The content of R7 and R6&nbsp;are not moved to SRR0 and&nbsp;SRR1.&nbsp; I am using the tool-chain from Freescale for 
2.6 kernel.&nbsp;</span></font></font></div>
<div class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span style="mso-tab-count: 1"></span></font></font>&nbsp;</div>
<div class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span style="mso-tab-count: 1">Any idea on this&nbsp;issue?</span></font></font></div>
<div class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span style="mso-tab-count: 1"></span></font></font>&nbsp;</div>
<div class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span style="mso-tab-count: 1">Thanks,</span></font></font></div>
<div class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span style="mso-tab-count: 1"></span></font></font>&nbsp;</div>
<div class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span style="mso-tab-count: 1">Mike</span></font></font></div>
<div class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span style="mso-tab-count: 1"></span></font></font>&nbsp;</div>
<div class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span style="mso-tab-count: 1"></span></font></font>&nbsp;</div>
<div class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span style="mso-tab-count: 1"></span></font></font>&nbsp;</div>
<div class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span style="mso-tab-count: 1">Code of head_e500.S:</span></font></font></div>
<div class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span style="mso-tab-count: 1"></span></font></font>&nbsp;</div>
<div class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span style="mso-tab-count: 1">&nbsp;</span></font></font></div>
<div class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>slwi<span style="mso-tab-count: 1">&nbsp; </span>r6,r6,5<span style="mso-tab-count: 2">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>/* setup new context with other address space */<br><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>bl<span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp; </span>1f<span style="mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>/* Find our address */
<br></font></font><font size="2"><font face="Courier New"><span lang="PT-BR" style="mso-ansi-language: PT-BR">1:<span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp; </span>mflr<span style="mso-tab-count: 1">&nbsp; </span>r9<br><span style="mso-tab-count: 1">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>rlwimi<span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>r7,r9,0,20,31<br><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>addi<span style="mso-tab-count: 1">&nbsp; </span>r7,r7,24<br><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>
mtspr<span style="mso-tab-count: 1"> </span>SRR0,r7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ........No change in SRR0<br><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>mtspr<span style="mso-tab-count: 1"> </span>SRR1,r6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;........No&nbsp;change in SRR1
<br><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>rfi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ........System crash<br><br>/* 4. Clear out PIDs &amp; Search info */<span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>l</font></font></div>
<div class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font size="2"><font face="Courier New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;li<span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp; </span>r6,0<br><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>mtspr<span style="mso-tab-count: 1">
 </span>SPRN_PID0,r6<br><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>mtspr<span style="mso-tab-count: 1"> </span>SPRN_PID1,r6<br><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>mtspr<span style="mso-tab-count: 1"> </span>SPRN_PID2,r6
<br><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>mtspr<span style="mso-tab-count: 1"> </span>SPRN_MAS6,r6</font></font><br>&nbsp;</div></span>

------=_Part_4955_24118053.1187122449993--
