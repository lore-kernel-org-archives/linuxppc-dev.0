Message-ID: <XFMail.990211235807.jeremy@goop.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.05.9902111905490.12241-100000@p12-42.hartford.dialin.ntplx.com>
Date: Thu, 11 Feb 1999 23:58:07 -0800 (PST)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Tom Rini <tmrini@ntplx.net>
Subject: RE: OF and NetBooting
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 12-Feb-99 Tom Rini wrote:
> 
> Hello,
>   After playing around a bit more with my iMac, I was wondering if anyone
> knew just what was going on here..  First, I've gotten the iMac to
> NFS-boot with BootX, and verified that bootp is setup right (ie it sets up
> the network, and I can tftp in the file from OF).  However, when I try and
> load a kernel from OF (either hd:vmlinux or enet:0,vmlinux) I get CLAIM
> failed.  Has anyone gotten past this?  I'm thinking it might be something
> we do really early on, as netbsd does boot (enet:0,netbsd.generic)

The build process generates bad ELF files which won't load.  The problem is
that the image and initrd segments have a load address of 0 and are not marked
as loadable.  The claim failed comes from OF trying to allocate memory at 0 for
those segments.  I experimented with trying to generate proper ELF files, but
was never fully successful on a G3 Mac.

        J

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
