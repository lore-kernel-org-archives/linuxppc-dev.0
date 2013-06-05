Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E22B52C0082
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Jun 2013 19:43:37 +1000 (EST)
Message-ID: <1370425396.3766.219.camel@pasglop>
Subject: Re: [PATCH v3 0/8] Nvram-to-pstore
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Wed, 05 Jun 2013 19:43:16 +1000
In-Reply-To: <51AEFE28.3040104@linux.vnet.ibm.com>
References: <20130425100952.21017.51799.stgit@aruna-ThinkPad-T420>
 <1370064348.3766.37.camel@pasglop> <51AEFE28.3040104@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: jkenisto@linux.vnet.ibm.com, tony.luck@intel.com, keescook@chromium.org,
 mahesh@linux.vnet.ibm.com, ccross@android.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org,
 cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-06-05 at 14:30 +0530, Aruna Balakrishnaiah wrote:
> Hi Ben,
> 
> On Saturday 01 June 2013 10:55 AM, Benjamin Herrenschmidt wrote:
> > Another question...
> >
> > Should the core pstore fail to unlink partitions that don't have
> > an ->erase callback ? IE. Why would you let anyone erase the OFW
> > common partition for example ? That means that userspace tools
> > can no longer manipulate it but we certainly don't want to remove
> > it from the nvram itself.
> 
> Since I do not have a callback for erase in nvram, pstore
> simply unlinks the file and will not delete the partition.

Right. My point is that it should probably refuse to unlink the file
too. What's the point in letting the user remove the file, potentially
making tools not working anymore, without any way to bring it back other
than a reboot ?

unlink makes sense if it also removes the partition. If it doesn't it
should just fail.

> > That leads to a deeper concern. Looking at how efi-pstore works,
> > it looks like they create a file for each var.
> >
> > This looks like something valuable we could do for something like
> > the common partition since typically it's made of name,value pairs.
> >
> > However, pstore is a flat space, while we have patitions which
> > themselves can be organized in name,value pairs (some at least)
> >
> > I wonder if it's time to introduce pstore directories... Or do
> > we stick to our special tools to interpret/change the name,value
> > pairs ?
> 
> Since pstore infrastructure creates the file in read-only mode
> creating files for name, value pairs will not be useful to us.
> So for now, we need to stick to our tools to interpret/change
> the name,value pairs.
> 
> And also, pstore filenames are controlled by pstore infrastructure
> so that would need quite some changes in the pstore infrastructure.
> 
> I think for now it would be better to dump the contents of common
> partition as it is.

Ok.

> >
> > Also do we want to add an ability to resize partitions ? Possibly
> > based on how much is written to them ?
> 
> Yes it will be good to that.
> 
> If your fine with patchset apart from the filenames of-config and common
> partitions. I will post the next version of it with powerpc prefix.

Yes, I'm ok with it.

Cheers,
Ben.

> >
> > Cheers,
> > Ben.
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
