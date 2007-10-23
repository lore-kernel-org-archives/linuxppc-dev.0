Return-Path: <michaelellerman@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id 4D57EDDE99
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 12:02:41 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so1207677nfd
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 19:02:40 -0700 (PDT)
Message-ID: <dc1166600710221902t1383ff88q421a17b1ff1382cd@mail.gmail.com>
Date: Tue, 23 Oct 2007 12:02:39 +1000
From: "Michael Ellerman" <michael@ellerman.id.au>
Sender: michaelellerman@gmail.com
To: "Greg Kroah-Hartman" <greg@kroah.com>
Subject: Re: [PATCH] Allow sysfs_remove_group() to be called on non-added
	groups
In-Reply-To: <096fae99bd9797c5484ed8f4b87b82e58737cdc0.1189657514.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <096fae99bd9797c5484ed8f4b87b82e58737cdc0.1189657514.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/13/07, Michael Ellerman <michael@ellerman.id.au> wrote:
> It would be nice to be able to do:
>
> for_each_thing(thing) {
>         error = sysfs_create_group(&thing->kobj, attrs);
>         if (error) {
>                 for_each_thing(thing)
>                         sysfs_remove_group(&thing->kobj, attrs);
>                 return error;
>         }
> }
>
> But there's a BUG_ON() in sysfs_remove_group() which hits if the attributes
> were never added.
>
> As discussed here ...
> http://ozlabs.org/pipermail/cbe-oss-dev/2007-July/002774.html
>
> .. we should just return in that case instead of BUG'ing.
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  fs/sysfs/group.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> index f318b73..a256775 100644
> --- a/fs/sysfs/group.c
> +++ b/fs/sysfs/group.c
> @@ -73,7 +73,8 @@ void sysfs_remove_group(struct kobject * kobj,
>
>         if (grp->name) {
>                 sd = sysfs_get_dirent(dir_sd, grp->name);
> -               BUG_ON(!sd);
> +               if (!sd)
> +                       return;
>         } else
>                 sd = sysfs_get(dir_sd);
>
>

Hi Greg,

I didn't see this in your series, any objections? AFAICT it still applies.

cheers
