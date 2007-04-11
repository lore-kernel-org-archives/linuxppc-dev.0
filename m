Return-Path: <mita@fixstars.com>
Date: Wed, 11 Apr 2007 11:35:08 +0900
From: Akinobu Mita <mita@fixstars.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 1/3] powerpc: delete -mstring option
Message-ID: <20070411023508.GA2197@localhost.localdomain>
References: <20070410111324.GA2957@localhost.localdomain>
	<16327e0d9602022d7ee57670ac23c383@kernel.crashing.org>
	<4FDD7344-D9AD-4DCF-8C10-E65B6CEC7762@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FDD7344-D9AD-4DCF-8C10-E65B6CEC7762@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 10, 2007 at 01:42:15PM -0500, Kumar Gala wrote:
> >This is the right solution, thank you for the patch.
> >But please fold these two together so that you're not
> >introducing a regression halfway the patch series.
> 
> I agree this looks good and merge patches 1/3 and 2/3 into a single  
> patch.

Thansk, this is updated patch.

From: Akinobu Mita <mita@fixstars.com>
Subject: powerpc: delete -mstring option

There is no reason to force -mstring option.

This patch removes -mstring option, and adds -mno-string option
for FLS_BOOKE (Because GCC is now putting string instructions
even if you don't specify -mstring).

Signed-off-by: Akinobu Mita <mita@fixstars.com>

---
 arch/powerpc/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: 2.6-git-ps3/arch/powerpc/Makefile
===================================================================
--- 2.6-git-ps3.orig/arch/powerpc/Makefile
+++ 2.6-git-ps3/arch/powerpc/Makefile
@@ -102,8 +102,8 @@ CFLAGS += $(call cc-option,-mno-altivec)
 # kernel considerably.
 CFLAGS += $(call cc-option,-funit-at-a-time)
 
-ifndef CONFIG_FSL_BOOKE
-CFLAGS		+= -mstring
+ifeq ($(CONFIG_FSL_BOOKE),y)
+CFLAGS         += -mno-string
 endif
 
 ifeq ($(CONFIG_6xx),y)
