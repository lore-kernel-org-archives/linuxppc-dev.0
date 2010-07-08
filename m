Return-Path: <jk@ozlabs.org>
Subject: Re: [PATCH 06/18] spufs: use llseek in all file operations
From: Jeremy Kerr <jk@ozlabs.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <1278538820-1392-7-git-send-email-arnd@arndb.de>
References: <1278538820-1392-1-git-send-email-arnd@arndb.de>
	<1278538820-1392-7-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 09:15:28 +0800
Message-ID: <1278551728.28333.55.camel@pororo.lan>
Mime-Version: 1.0
Cc: John Kacur <jkacur@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnd,

> The default for llseek is changing, so we need
> explicit operations everywhere.

Looks good, but:

> @@ -2151,7 +2166,7 @@ static ssize_t spufs_ibox_info_read(struct file *file, char __user *buf,
>  static const struct file_operations spufs_ibox_info_fops = {
>  	.open = spufs_info_open,
>  	.read = spufs_ibox_info_read,
> -	.llseek  = generic_file_llseek,
> +	.llseek = no_llseek,
>  };
> 
>  static ssize_t __spufs_wbox_info_read(struct spu_context *ctx,
> @@ -2194,7 +2209,7 @@ static ssize_t spufs_wbox_info_read(struct file *file, char __user *buf,
>  static const struct file_operations spufs_wbox_info_fops = {
>  	.open = spufs_info_open,
>  	.read = spufs_wbox_info_read,
> -	.llseek  = generic_file_llseek,
> +	.llseek = no_llseek,
>  };
> 

Why the change in behaviour for the mbox info files?

Cheers,


Jeremy
