Message-ID: <3FE814FF.7020503@primagraphics.co.uk>
Date: Tue, 23 Dec 2003 10:12:15 +0000
From: Mark Powell <medp@primagraphics.co.uk>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Cc: Davey <daveywu@transengines.com>
Subject: Re: patch for ibm 405ep emac driver in linux-2.4.22 and 2.4.23
References: <C7FFFEA58B43D311920D0004ACE5333F10E4F46C@amer25.avnet.com> <29449.216.110.51.8.1071877375.squirrel@www.orkun.us> <1072105831.4163.15.camel@localhost.localdomain> <001d01c3c923$db2ca3c0$5100a8c0@davey>
In-Reply-To: <001d01c3c923$db2ca3c0$5100a8c0@davey>
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Davey wrote:

>Some time ago Stefan and I had reported that both ethernet interfaces
>cannot work well together. Sorry I have lost all old mails when I
>reinstall my computer. We have find that this problem is caused by
>that the base address of eht1 is wrong set. Follow by my patch for
>linux-2.4.22 and linux-2.4.23. I have test the patch and it work well.

shouldn't that just be:

Index: arch/ppc/platforms/ibm405ep.c
===================================================================
RCS file:
/P2/Hawkeye557/CVS_Repository/Hawkeye557/Linux-405GP/linuxppc_2_4_devel/arch/ppc/platforms/ibm405ep.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 ibm405ep.c
--- arch/ppc/platforms/ibm405ep.c 2003/12/16 20:12:55 1.1.1.2
+++ arch/ppc/platforms/ibm405ep.c 2003/12/23 10:07:52
@@ -103,7 +103,7 @@
{ .vendor = OCP_VENDOR_IBM,
.function = OCP_FUNC_EMAC,
.index = 1,
- .paddr = EMAC0_BASE,
+ .paddr = EMAC1_BASE,
.irq = BL_MAC_ETH1,
.pm = OCP_CPM_NA,
.additions = &ibm405ep_emac1_def,

--
Mark Powell, Senior Software Engineer, Primagraphics Limited
New Cambridge House, Litlington, nr.Royston, Herts, SG8 0SS, UK
Tel. +44 1763 852222, Fax. 853324, http://www.primagraphics.co.uk

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
