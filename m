Date: Mon, 28 Oct 2002 19:38:43 -0800 (PST)
From: Paul White <pwhite@bivio.net>
To: Jim Potter <jrp@wvi.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: NFS client-side components question
In-Reply-To: <3DBDD68C.CD41E51D@wvi.com>
Message-ID: <Pine.LNX.4.21.0210281936170.26340-100000@stimpy.bivio.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim,

It sounds like its trying to use portmap for locking purposes.  Try
using a -o nolock argument to your mount call, as it sounds like you
don't have the port mapper installed or running on your ram disk.
This is what we had to do with ours, and it works great.

Here's what we do:

mount -t nfs -o nolock $SERVER:/home/log /log

Hope this helps..

Paul

On Mon, 28 Oct 2002, Jim Potter wrote:

>
> I'm developing a moderate sized ramdisk image to be used on an embedded
> project, and I'm having trouble getting all of the NFS client-side file
> dependencies sorted out on the ramdisk.  I'm using YDL installed on
> powermacs for my hosts & servers (not cross-hosted from x86 boxes).  The
> NFS mounts work fine when mounted from another powermac or when the
> embedded system is Root-On-NFS booted (both of which have a full YDL
> install).
>
> The problem is that when the embedded system is booted to ramdisk, and
> then an NFS mount of the server is attempted;  the mount command goes
> away, and eventually a "portmap: server localhost not responding, timed
> out" message pops up.  The NFS server box is listed in the /etc/hosts
> file.
>
> My ramdisk image has been built by taking various components from a YDL
> install;  this is so that the target embedded environment (ramdisk) has
> compatibility with customer's lab machines (typically YDL boxes).  It's
> my opinion that I have missed something on the client-side when
> assembling the ramdisk image.  Does anyone know where I can find a
> listing of the dependencies within the various NFS client components
> (mount, nfs, rpc, libs, etc)?  Thanks, everyone.
>
> --
> Sincerely,
>
> Jim Potter
> 45th Parallel Processing
>
>   Firefighting: Bustin' ours, Savin' yours.
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
