Date: Thu, 11 Oct 2001 16:18:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Val Henson <val@nmt.edu>,
	Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: SBS Palomar II/IV/V port
Message-ID: <20011011161848.B21564@cpe-24-221-152-185.az.sprintbbd.net>
References: <0110092125.AA22665@ivan.Harhan.ORG> <20011010122415.A22918@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011010122415.A22918@boardwalk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 10, 2001 at 12:24:15PM -0600, Val Henson wrote:
>
> On Tue, Oct 09, 2001 at 02:25:03PM -0700, Michael Sokolov wrote:
>
> > Some other bi_rec fixes may be needed (initrd ones are broken I think).
>
> Indeed!  This is on my list of stuff to do - straighten out once and
> for all how BI_INITRD works and then rewrite the Gemini boot process
> to use it.  It seemed like we had two interpretations:
>
> 1. The BI_INITRD boot record contains the start address and the size
>    of the initrd.

Okay, does the following look right/work for everyone?  (With a similar
change to arch/ppc64/kernel/setup.c).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/ppc/kernel/setup.c 1.60 vs edited =====
--- 1.60/arch/ppc/kernel/setup.c	Thu Sep 27 09:01:14 2001
+++ edited/arch/ppc/kernel/setup.c	Thu Oct 11 16:15:45 2001
@@ -496,7 +496,7 @@
 #ifdef CONFIG_BLK_DEV_INITRD
 		case BI_INITRD:
 			initrd_start = data[0];
-			initrd_end = data[0] + rec->size;
+			initrd_end = data[0] + data[1];
 			break;
 #endif /* CONFIG_BLK_DEV_INITRD */
 #ifdef CONFIG_ALL_PPC

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
