Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Dwight Engen <dwight.engen@oracle.com>
Subject: Re: linux-next: build failure after merge of the final tree
Date: Tue, 20 Aug 2013 22:46:30 +0200
References: <20130820172052.1f0d89ddf6a1a40ef70333fd@canb.auug.org.au>
 <20130820120702.000b044e@oracle.com>
In-Reply-To: <20130820120702.000b044e@oracle.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201308202246.30869.arnd@arndb.de>
Cc: cbe-oss-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 David Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 xfs@oss.sgi.com, Ben Myers <bpm@sgi.com>, linux-next@vger.kernel.org,
 Gao feng <gaofeng@cn.fujitsu.com>, linuxppc-dev@lists.ozlabs.org,
 Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 20 August 2013, Dwight Engen wrote:
> diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
> index f390042..90fb308 100644
> --- a/arch/powerpc/platforms/cell/spufs/inode.c
> +++ b/arch/powerpc/platforms/cell/spufs/inode.c
> @@ -620,12 +620,12 @@ spufs_parse_options(struct super_block *sb, char *options, struct inode *root)
>                 case Opt_uid:
>                         if (match_int(&args[0], &option))
>                                 return 0;
> -                       root->i_uid = option;
> +                       root->i_uid = make_kuid(&init_user_ns, option);
>                         break;
>                 case Opt_gid:
>                         if (match_int(&args[0], &option))
>                                 return 0;
> -                       root->i_gid = option;
> +                       root->i_gid = make_kgid(&init_user_ns, option);
>                         break;
>                 case Opt_mode:
>                         if (match_octal(&args[0], &option))

Doesn't this mean the uid/gid is taken from the initial namespace rather than
from the namespace of the 'mount' process calling this? I think the logical
choice would be to have the UID be the one that gets passed here in the caller's
namespace.

	Arnd
