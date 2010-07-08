Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 06/18] spufs: use llseek in all file operations
Date: Thu, 8 Jul 2010 15:02:36 +0200
References: <1278538820-1392-1-git-send-email-arnd@arndb.de>
	<1278538820-1392-7-git-send-email-arnd@arndb.de>
	<1278551728.28333.55.camel@pororo.lan>
In-Reply-To: <1278551728.28333.55.camel@pororo.lan>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201007081502.37133.arnd@arndb.de>
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

On Thursday 08 July 2010, Jeremy Kerr wrote:
> > @@ -2151,7 +2166,7 @@ static ssize_t spufs_ibox_info_read(struct file *file, char __user *buf,
> >  static const struct file_operations spufs_ibox_info_fops = {
> >       .open = spufs_info_open,
> >       .read = spufs_ibox_info_read,
> > -     .llseek  = generic_file_llseek,
> > +     .llseek = no_llseek,
> >  };
> > 
> >  static ssize_t __spufs_wbox_info_read(struct spu_context *ctx,
> > @@ -2194,7 +2209,7 @@ static ssize_t spufs_wbox_info_read(struct file *file, char __user *buf,
> >  static const struct file_operations spufs_wbox_info_fops = {
> >       .open = spufs_info_open,
> >       .read = spufs_wbox_info_read,
> > -     .llseek  = generic_file_llseek,
> > +     .llseek = no_llseek,
> >  };
> > 
> 
> Why the change in behaviour for the mbox info files?
> 

D'oh, that wasn't intentional. I guess what must have happened is that I first
added generic_file_llseek to all file_operations in spufs and then made up my
mind and chose what I thought was correct in each case, which broke these.
Of course, these *_info_fops should be seekable.

	Arnd
