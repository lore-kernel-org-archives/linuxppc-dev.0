Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BFD2DB71AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Sep 2011 16:47:01 +1000 (EST)
Date: Thu, 15 Sep 2011 08:35:43 +0200
From: Greg KH <gregkh@suse.de>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] memory hotplug: Refuse to add unaligned memory regions
Message-ID: <20110915063543.GA29211@suse.de>
References: <20110915062615.782bc4df@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110915062615.782bc4df@kryten>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 15, 2011 at 06:26:15AM +1000, Anton Blanchard wrote:
> 
> The sysfs memory probe interface allows unaligned regions
> to be added:
> 
> # echo 0xffffff > /sys/devices/system/memory/probe
> 
> # cat /proc/iomem 
> 00ffffff-01fffffe : System RAM
> 01ffffff-02fffffe : System RAM
> 02ffffff-03fffffe : System RAM
> 03ffffff-04fffffe : System RAM
> 04ffffff-05fffffe : System RAM
> 
> Return -EINVAL instead of creating these bad regions.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---

Is this something that should go into 3.1 and older kernels to properly
handle this type of error?

greg k-h
