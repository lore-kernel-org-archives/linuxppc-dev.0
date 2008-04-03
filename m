Return-Path: <ravi.rao@rflelect.com>
In-Reply-To: <OF39A36E1A.054DB15D-ON8525741F.00650F27-8525741F.00663A93@slpower.com>
To: ravi.rao@rflelect.com
Subject: Re: ppc405ep and Ready enable in EBC0_BnAP register
MIME-Version: 1.0
Message-ID: <OF4932B1D2.869A85A9-ON85257420.00656EAF-85257420.006777FE@slpower.com>
From: ravi.rao@rflelect.com
Date: Thu, 3 Apr 2008 14:48:57 -0400
Content-Type: multipart/alternative;
	boundary="=_alternative 006777FC85257420_="
Cc: linuxppc-embedded-bounces+ravi.rao=rflelect.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 006777FC85257420_=
Content-Type: text/plain; charset="US-ASCII"

Hi All,
   Some more updates..
I tried to single step using BDI2000 to narrow down what may be happening. 
This is what I observed..
When I tried to access a TDMoIP reg which is memory mapped I did not see 
any chipselect but got the bus error with the following Info..

********************* Screen dump 
****************************************************
# echo f9200000 1 > /proc/rfl_tdmoip/prep_2dump_tdmoip_cfg
Ready to dump 0x1 TDMOIP regs starting from 0xf9200000(Phy) 
0xc5380000(Virt)
# cat /proc/rfl_tdmoip/dump_tdmoip_cfg

Data machine check in kernel mode.
PLB0: BEAR= 0xc0123644 ACR=   0x00000000 BESR=  0x00800000
PLB0 to OPB: BEAR= 0xef60071c BESR0= 0x00000000 BESR1= 0x00000000
Oops: machine check, sig: 7 [#1]
NIP: 00001100 LR: C0123764 CTR: 00000001
REGS: c0240f50 TRAP: 0202   Not tainted  (2.6.21)
MSR: 00001000 <ME>  CR: 84044404  XER: 00000007
TASK = c3f674b0[652] 'cat' THREAD: c3a86000
GPR00: 00000001 C3A87650 C3F674B0 C3AAE000 C3A87EAC 00000000 00000C00 
C3A87EA8
GPR08: 00000000 00000000 FFFFFFFF C5380000 44044408 100A54C0 03FF9C00 
00000001
GPR16: 0000005E C01DB87C C02E7F78 C01E1CA8 C3A87EA8 C01E1C78 C3A87EAC 
C3FD4320
GPR24: C3AAE000 00000000 C3A87F20 C0216C90 C3A87658 C3A87EA8 00000C00 
C3AAE000
Call Trace:
[C3A87E80] [C0123764]
[C3A87EA0] [C009BA60]
[C3A87EF0] [C0063E6C]
[C3A87F10] [C00642C8]
[C3A87F40] [C0002CB4]
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
Bus error

Upon futher digging up in the PPC405EP user manual Found the Error BESR 
referring to is 
Figure 26-190. PLB Error Status Register (PLB0_BESR)
Bit 8 indicates  PTE2 Master 2(processor core DCU) PLB Timeout Error 
Status
0 means No master 2 timeout error
1 means Master 2 timeout error 
Any thoughts why we would get Timeouts from DCU ??

Thanks,                            
Ravishankar Govindarao
RFL Electronics Inc.
E-mail : Ravi.Rao@rflelect.com
Voice: 973.334.3100 Ext. 233
Fax: 973.334.3863
--=_alternative 006777FC85257420_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi All,</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;Some more updates..</font>
<br><font size=2 face="sans-serif">I tried to single step using BDI2000
to narrow down what may be happening. This is what I observed..</font>
<br><font size=2 face="sans-serif">When I tried to access a TDMoIP reg
which is memory mapped I did not see any chipselect but got the bus error
with the following Info..</font>
<br>
<br><font size=2 face="sans-serif">********************* Screen dump ****************************************************</font>
<br><font size=2 face="Courier New"># echo f9200000 1 &gt; /proc/rfl_tdmoip/prep_2dump_tdmoip_cfg</font>
<br><font size=2 face="Courier New">Ready to dump 0x1 TDMOIP regs starting
from 0xf9200000(Phy) 0xc5380000(Virt)</font>
<br><font size=2 face="Courier New"># cat /proc/rfl_tdmoip/dump_tdmoip_cfg</font>
<br>
<br><font size=2 face="Courier New">Data machine check in kernel mode.</font>
<br><font size=2 face="Courier New"><b>PLB0: BEAR= 0xc0123644 ACR= &nbsp;
0x00000000 BESR= &nbsp;0x00800000</b></font>
<br><font size=2 face="Courier New">PLB0 to OPB: BEAR= 0xef60071c BESR0=
0x00000000 BESR1= 0x00000000</font>
<br><font size=2 face="Courier New">Oops: machine check, sig: 7 [#1]</font>
<br><font size=2 face="Courier New">NIP: 00001100 LR: C0123764 CTR: 00000001</font>
<br><font size=2 face="Courier New">REGS: c0240f50 TRAP: 0202 &nbsp; Not
tainted &nbsp;(2.6.21)</font>
<br><font size=2 face="Courier New">MSR: 00001000 &lt;ME&gt; &nbsp;CR:
84044404 &nbsp;XER: 00000007</font>
<br><font size=2 face="Courier New">TASK = c3f674b0[652] 'cat' THREAD:
c3a86000</font>
<br><font size=2 face="Courier New">GPR00: 00000001 C3A87650 C3F674B0 C3AAE000
C3A87EAC 00000000 00000C00 C3A87EA8</font>
<br><font size=2 face="Courier New">GPR08: 00000000 00000000 FFFFFFFF C5380000
44044408 100A54C0 03FF9C00 00000001</font>
<br><font size=2 face="Courier New">GPR16: 0000005E C01DB87C C02E7F78 C01E1CA8
C3A87EA8 C01E1C78 C3A87EAC C3FD4320</font>
<br><font size=2 face="Courier New">GPR24: C3AAE000 00000000 C3A87F20 C0216C90
C3A87658 C3A87EA8 00000C00 C3AAE000</font>
<br><font size=2 face="Courier New">Call Trace:</font>
<br><font size=2 face="Courier New">[C3A87E80] [C0123764]</font>
<br><font size=2 face="Courier New">[C3A87EA0] [C009BA60]</font>
<br><font size=2 face="Courier New">[C3A87EF0] [C0063E6C]</font>
<br><font size=2 face="Courier New">[C3A87F10] [C00642C8]</font>
<br><font size=2 face="Courier New">[C3A87F40] [C0002CB4]</font>
<br><font size=2 face="Courier New">Instruction dump:</font>
<br><font size=2 face="Courier New">XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX</font>
<br><font size=2 face="Courier New">XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX</font>
<br><font size=2 face="Courier New">Bus error</font>
<br>
<br><font size=2 face="sans-serif">Upon futher digging up in the PPC405EP
user manual Found the Error BESR referring to is </font>
<br><font size=2 face="Arial"><b>Figure 26-190. PLB Error Status Register
(PLB0_BESR)</b></font>
<br><font size=1 face="Arial">Bit 8 indicates &nbsp;PTE2 Master 2(processor
core DCU) PLB Timeout Error Status</font>
<br><font size=1 face="Arial">0 means No master 2 timeout error</font>
<br><font size=1 face="Arial">1 means Master 2 timeout error &nbsp; &nbsp;
</font>
<br><font size=1 face="Arial">Any thoughts why we would get Timeouts from
DCU ??</font>
<br>
<br><font size=1 face="Arial">Thanks, &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=2 face="sans-serif"><br>
</font><font size=2 face="Tms Rmn">Ravishankar Govindarao<br>
RFL Electronics Inc.<br>
E-mail</font><font size=1 face="Tms Rmn"> </font><font size=2 face="Tms Rmn">:
</font><a href=mailto:Ravi.Rao@rflelect.com><font size=2 color=blue face="Tms Rmn"><u>Ravi.Rao@rflelect.com</u></font></a>
<br><font size=2 face="Tms Rmn">Voice: 973.334.3100 Ext. 233<br>
Fax: 973.334.3863</font>
--=_alternative 006777FC85257420_=--
