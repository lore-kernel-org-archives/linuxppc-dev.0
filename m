Return-Path: <alan@akb.net>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by ozlabs.org (Postfix) with ESMTP id 4CD93DE032
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 04:42:12 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so1470819nzh
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 10:42:10 -0700 (PDT)
Message-ID: <bfa0697f0710301042j5d899790k753050f22079f3d6@mail.gmail.com>
Date: Tue, 30 Oct 2007 11:42:09 -0600
From: "Alan Bennett" <embedded@akb.net>
Sender: alan@akb.net
To: "Scott Wood" <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Continued serial headaches
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3726_10052004.1193766129740"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_3726_10052004.1193766129740
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Well, now that I've got IRQs requestable, I'm back to battling SCC1 / SCC4
initialization,

I've verified the iop structures, and things look set-up correctly.
    /* SCC1 */
    {2, 14, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
    {2, 15, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
    {3, 29, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
    {3, 30, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
    {3, 31, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
    /* SCC4 */
    {3, 21, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
    {3, 22, CPM_PIN_INPUT | CPM_PIN_PRIMARY},

I've also verified that upon first use (echo "test" > /dev/ttyCPM[12] the
brgs are configured)

SCC1
  cpm_uart_startup:417
  CPM uart[1]:startup on IRQ: 40 - request returned 0
  cpm_uart_startup:432 CPM uart[1] is scc
  CPM uart[1]:set_termios
  cpm_setbrg [cpm2_common.c:106] e00119f0:00010140
  CPM uart[1]:shutdown
SCC4
  cpm_uart_startup:417
  CPM uart[2]:startup on IRQ: 43 - request returned 0
  cpm_uart_startup:432 CPM uart[2] is scc
  CPM uart[2]:set_termios
  cpm_setbrg [cpm2_common.c:106] e00119fc:00010140
  CPM uart[2]:shutdown
  CPM uart[2]:initbd

However, SCC1 continues to get locked.

Am I missing something in the PRAM areas?
SMC1 (ttyCPM0...)
  e0008000 : 00c000e0 30300020 00000000 eefe3e7a
  e0008010 : 00c07331 11b6b05f 30440000 07f4d082
  e0008020 : 00e00003 746562ec d98ceffd 0dec67e3
  e0008030 : df7b2db5 5f0bf2dc 00205ce8 00010000
  e0008040 : 00000000 0000fc9d 00000000 d08a0000
  e0008050 : 80008000 80008000 80008000 80008000
SCC1
  e0008000 : 00c000e0 30300020 00000000 eefe3e7a
  e0008010 : 00c07331 11b6b05f 30440000 07f4d082
  e0008020 : 00e00003 746562ec d98ceffd 0dec67e3
  e0008030 : df7b2db5 5f0bf2dc 00205ce8 00010000
  e0008040 : 00000000 0000fc9d 00000000 d08a0000
  e0008050 : 80008000 80008000 80008000 80008000
SCC4
  e0008300 : 01000120 30300020 30401000 07f4e001
  e0008310 : 0100001f 993fb24d 30004000 07f4e0a2
  e0008320 : 01300000 0d0a8379 fedddfdc 94a967eb
  e0008330 : 5d2b06bd 4708b3ce 0020001f 00010000
  e0008340 : 00000000 00002804 00000000 e8a60000
  e0008350 : 80008000 80008000 80008000 80008000



-Alan

------=_Part_3726_10052004.1193766129740
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Well, now that I&#39;ve got IRQs requestable, I&#39;m back to battling SCC1 / SCC4 initialization, <br><br>I&#39;ve verified the iop structures, and things look set-up correctly. <br>&nbsp;&nbsp;&nbsp; /* SCC1 */ <br>&nbsp;&nbsp;&nbsp; {2, 14, CPM_PIN_INPUT | CPM_PIN_PRIMARY}, 
<br>&nbsp;&nbsp;&nbsp; {2, 15, CPM_PIN_INPUT | CPM_PIN_PRIMARY},&nbsp; <br>&nbsp;&nbsp;&nbsp; {3, 29, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY}, <br>&nbsp;&nbsp;&nbsp; {3, 30, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},<br>&nbsp;&nbsp;&nbsp; {3, 31, CPM_PIN_INPUT | CPM_PIN_PRIMARY},<br>&nbsp;&nbsp;&nbsp; /* SCC4 */
<br>&nbsp;&nbsp;&nbsp; {3, 21, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},<br>&nbsp;&nbsp;&nbsp; {3, 22, CPM_PIN_INPUT | CPM_PIN_PRIMARY},<br><br> I&#39;ve also verified that upon first use (echo &quot;test&quot; &gt; /dev/ttyCPM[12] the brgs are configured)<br>
<br>SCC1<br>&nbsp; cpm_uart_startup:417<br>&nbsp; CPM uart[1]:startup on IRQ: 40 - request returned 0<br>&nbsp; cpm_uart_startup:432 CPM uart[1] is scc<br>&nbsp; CPM uart[1]:set_termios<br>&nbsp; cpm_setbrg [cpm2_common.c:106] e00119f0:00010140<br>
&nbsp; CPM uart[1]:shutdown<br>SCC4<br>&nbsp; cpm_uart_startup:417<br>&nbsp; CPM uart[2]:startup on IRQ: 43 - request returned 0<br>&nbsp; cpm_uart_startup:432 CPM uart[2] is scc<br>&nbsp; CPM uart[2]:set_termios<br>&nbsp; cpm_setbrg [cpm2_common.c:106] e00119fc:00010140
<br>&nbsp; CPM uart[2]:shutdown<br>&nbsp; CPM uart[2]:initbd<br><br>However, SCC1 continues to get locked.&nbsp; <br><br>Am I missing something in the PRAM areas?<br>SMC1 (ttyCPM0...)<br>&nbsp; e0008000 : 00c000e0 30300020 00000000 eefe3e7a<br>
&nbsp; e0008010 : 00c07331 11b6b05f 30440000 07f4d082<br>&nbsp; e0008020 : 00e00003 746562ec d98ceffd 0dec67e3<br>&nbsp; e0008030 : df7b2db5 5f0bf2dc 00205ce8 00010000<br>&nbsp; e0008040 : 00000000 0000fc9d 00000000 d08a0000<br>&nbsp; e0008050 : 80008000 80008000 80008000 80008000
<br>SCC1<br>&nbsp; e0008000 : 00c000e0 30300020 00000000 eefe3e7a<br>&nbsp; e0008010 : 00c07331 11b6b05f 30440000 07f4d082<br>&nbsp; e0008020 : 00e00003 746562ec d98ceffd 0dec67e3<br>&nbsp; e0008030 : df7b2db5 5f0bf2dc 00205ce8 00010000<br>&nbsp; e0008040 : 00000000 0000fc9d 00000000 d08a0000
<br>&nbsp; e0008050 : 80008000 80008000 80008000 80008000<br>SCC4<br>&nbsp; e0008300 : 01000120 30300020 30401000 07f4e001<br>&nbsp; e0008310 : 0100001f 993fb24d 30004000 07f4e0a2<br>&nbsp; e0008320 : 01300000 0d0a8379 fedddfdc 94a967eb<br>&nbsp; e0008330 : 5d2b06bd 4708b3ce 0020001f 00010000
<br>&nbsp; e0008340 : 00000000 00002804 00000000 e8a60000<br>&nbsp; e0008350 : 80008000 80008000 80008000 80008000<br><br><br><br>-Alan<br>

------=_Part_3726_10052004.1193766129740--
