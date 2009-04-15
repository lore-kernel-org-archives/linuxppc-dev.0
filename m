Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1873CDE29F
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 08:32:04 +1000 (EST)
Date: Wed, 15 Apr 2009 15:27:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Harry Ciao <qingtao.cao@windriver.com>
Subject: Re: [v2 PATCH 1/3] EDAC: Add CPC925 Memory Controller driver
Message-Id: <20090415152704.b7ebddc7.akpm@linux-foundation.org>
In-Reply-To: <1239602716-18352-2-git-send-email-qingtao.cao@windriver.com>
References: <1239602716-18352-1-git-send-email-qingtao.cao@windriver.com>
	<1239602716-18352-2-git-send-email-qingtao.cao@windriver.com>
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

On Mon, 13 Apr 2009 14:05:14 +0800
Harry Ciao <qingtao.cao@windriver.com> wrote:

> Introduce IBM CPC925 EDAC driver, which makes use of ECC, CPU and
> HyperTransport Link error detections and corrections on the IBM
> CPC925 Bridge and Memory Controller.

A wee cleanup:

--- a/drivers/edac/cpc925_edac.c~edac-add-cpc925-memory-controller-driver-cleanup
+++ a/drivers/edac/cpc925_edac.c
@@ -291,9 +291,6 @@ struct cpc925_dev_info {
 	void (*check)(struct edac_device_ctl_info *edac_dev);
 };
 
-
-static int edac_mc_idx;
-
 /* Get total memory size from Open Firmware DTB */
 static void get_total_mem(struct cpc925_mc_pdata *pdata)
 {
@@ -866,6 +863,7 @@ static int cpc925_mc_get_channels(void _
 
 static int __devinit cpc925_probe(struct platform_device *pdev)
 {
+	static int edac_mc_idx;
 	struct mem_ctl_info *mci;
 	void __iomem *vbase;
 	struct cpc925_mc_pdata *pdata;
_
