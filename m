Date: Fri, 15 Nov 2002 15:51:38 -0600
From: "William A. Gatliff" <bgat@billgatliff.com>
To: Jerry Van Baren <vanbaren_gerald@si.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: NFS root manipulation without being superuser?
Message-ID: <20021115155138.T5906@saturn.billgatliff.com>
Reply-To: bgat@billgatliff.com
References: <0060C09C.C21188@nasa.gov> <5.1.0.14.2.20021115150906.0224ce08@falcon.si.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20021115150906.0224ce08@falcon.si.com>; from vanbaren_gerald@si.com on Fri, Nov 15, 2002 at 03:16:16PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jerry:

On Fri, Nov 15, 2002 at 03:16:16PM -0500, Jerry Van Baren wrote:
>
> How about this thought... on your development system, make a group "xroot"
> (export root, or maybe name it "grub" to make a bad pun)

How about "tuber"?  :^)

> and chown your NFS files currently owned by "root" to "xroot".  You
> can add yourself into the "xroot" group and make sure all the NFS
> exported root file system have group r/w privileges.  Now you can
> play with the files to your heart's content because you are part of
> the group that has write permissions.  When you are happy with your
> NFS exported root file system, change the group ownership of "xroot"
> back to "root".  With a little thought and a lot of care ;-), you
> should be able to write a script that does the group change back &
> forth.

Maybe just this:

# cd <nfs-root-dir> && find . -name "*" | xargs chown xroot:xroot

What about the files that the client creates or modifies,
i.e. resolv.conf in a DHCP setting?  I think those files will still
get created with root ownership.  It's almost as if NFS needs
translate the UID of the files both inbound and outbound.

Other than that, your suggestion looks great.


b.g.
--
Bill Gatliff
Do you do embedded GNU?  I do!
See http://billgatliff.com for details.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
