Message-Id: <5.1.0.14.2.20021115173153.02373680@falcon.si.com>
Date: Fri, 15 Nov 2002 17:42:45 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: NFS root manipulation without being superuser?
In-Reply-To: <20021115155138.T5906@saturn.billgatliff.com>
References: <5.1.0.14.2.20021115150906.0224ce08@falcon.si.com>
 <0060C09C.C21188@nasa.gov>
 <5.1.0.14.2.20021115150906.0224ce08@falcon.si.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tuber.  I like that :-).

My suggestion was slightly different from your script:
1) Your script is going to chown _all_ the exported files.  That is bad.
2) I would change only the _group_, not the owner.  This will prevent
breaking SUID programs.

Your oneliner (UNTESTED) would then be:
# cd <nfs-root-dir> && find . -uid 0 | xargs chgrp xroot

and changing back would be:
# cd <nfs-root-dir> && find . -uid 0 | xargs chgrp root

Note that, since the owner doesn't change, it is easy to mess with only the
root-owned files.

With respect to newly created files, I don't have a good solution, but the
above script would be simple to fix them up again.  You could even use
"-uid 0 -gid 0" to find only the newly created ones.

gvb


At 03:51 PM 11/15/2002 -0600, William A. Gatliff wrote:
>Jerry:
>
>On Fri, Nov 15, 2002 at 03:16:16PM -0500, Jerry Van Baren wrote:
> >
> > How about this thought... on your development system, make a group "xroot"
> > (export root, or maybe name it "grub" to make a bad pun)
>
>How about "tuber"?  :^)
>
> > and chown your NFS files currently owned by "root" to "xroot".  You
> > can add yourself into the "xroot" group and make sure all the NFS
> > exported root file system have group r/w privileges.  Now you can
> > play with the files to your heart's content because you are part of
> > the group that has write permissions.  When you are happy with your
> > NFS exported root file system, change the group ownership of "xroot"
> > back to "root".  With a little thought and a lot of care ;-), you
> > should be able to write a script that does the group change back &
> > forth.
>
>Maybe just this:
>
># cd <nfs-root-dir> && find . -name "*" | xargs chown xroot:xroot
>
>What about the files that the client creates or modifies,
>i.e. resolv.conf in a DHCP setting?  I think those files will still
>get created with root ownership.  It's almost as if NFS needs
>translate the UID of the files both inbound and outbound.
>
>Other than that, your suggestion looks great.
>
>
>b.g.
>--
>Bill Gatliff
>Do you do embedded GNU?  I do!
>See http://billgatliff.com for details.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
