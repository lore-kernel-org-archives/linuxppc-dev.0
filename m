Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B157EDE454
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 08:32:32 +1000 (EST)
Date: Wed, 15 Apr 2009 15:27:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Harry Ciao <qingtao.cao@windriver.com>
Subject: Re: [v2 PATCH 2/3] EDAC: Add edac_device_alloc_index()
Message-Id: <20090415152730.79d8053c.akpm@linux-foundation.org>
In-Reply-To: <1239602716-18352-3-git-send-email-qingtao.cao@windriver.com>
References: <1239602716-18352-1-git-send-email-qingtao.cao@windriver.com>
	<1239602716-18352-2-git-send-email-qingtao.cao@windriver.com>
	<1239602716-18352-3-git-send-email-qingtao.cao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: norsk5@yahoo.com, bluesmoke-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 13 Apr 2009 14:05:15 +0800
Harry Ciao <qingtao.cao@windriver.com> wrote:

> Add edac_device_alloc_index(), because for MAPLE platform there may
> exist several EDAC driver modules that could make use of
> edac_device_ctl_info structure at the same time. The index allocation
> for these structures should be taken care of by EDAC core.
> 

From: Andrew Morton <akpm@linux-foundation.org>

keep things neat.  Also avoids having global identifier device_index
shadowed by local identifier device_index.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Doug Thompson <norsk5@yahoo.com>
Cc: Harry Ciao <qingtao.cao@windriver.com>
Cc: Kumar Gala <galak@gate.crashing.org>
Cc: Michael Ellerman <michael@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/edac/edac_device.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/edac/amd8111_edac.c~edac-add-edac_device_alloc_index-cleanup drivers/edac/amd8111_edac.c
diff -puN drivers/edac/edac_core.h~edac-add-edac_device_alloc_index-cleanup drivers/edac/edac_core.h
diff -puN drivers/edac/edac_device.c~edac-add-edac_device_alloc_index-cleanup drivers/edac/edac_device.c
--- a/drivers/edac/edac_device.c~edac-add-edac_device_alloc_index-cleanup
+++ a/drivers/edac/edac_device.c
@@ -37,7 +37,6 @@
  */
 static DEFINE_MUTEX(device_ctls_mutex);
 static LIST_HEAD(edac_device_list);
-static atomic_t device_indexes = ATOMIC_INIT(0);
 
 #ifdef CONFIG_EDAC_DEBUG
 static void edac_device_dump_device(struct edac_device_ctl_info *edac_dev)
@@ -499,6 +498,8 @@ void edac_device_reset_delay_period(stru
  */
 int edac_device_alloc_index(void)
 {
+	static atomic_t device_indexes = ATOMIC_INIT(0);
+
 	return atomic_inc_return(&device_indexes) - 1;
 }
 EXPORT_SYMBOL_GPL(edac_device_alloc_index);
_
