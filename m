From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <hemphill@drea.dnd.ca>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	<yellowdog-general@lists.yellowdoglinux.com>
Subject: Re: Ti Powerbooks and YDL 2.1 - Problems
Date: Tue, 6 Nov 2001 11:06:56 +0100
Message-Id: <20011106100656.20008@smtp.adsl.oleane.com>
In-Reply-To: <3BE74DCD.3070407@drea.dnd.ca>
References: <3BE74DCD.3070407@drea.dnd.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Well I've just spent an interesting two days documenting a problem with
>the Ti Powerbooks and the 2.4 series kernels.  I have access to two
>500Mhz Ti's with the Matshita DVD-ROM SR-8187 drives.  When I tried to
>follow Dan Burcaw's experimental instructions on doing a yup update of
>YDL2.0 to 2.1 I ran into the problem that a mount of any CD returned the
>error message "wrong media type" (I hadn't used the CD at all since
>moving to the 2.4 series kernels).  After trying all the various ways of
>mounting an ISO CD I decided to try the 2.2 series kernels (which of
>course are on the 2.0 CD - catch 22).  After downloading the old kernel
>RPM's and installing them I was able to mount the CD with no problem and
>actually completed the yup update to 2.1.  However with the new 2.4.10
>kernel in place I'm back to the error message if I try and mount the CD
>I used to do the update.  I've tried the latest kernels from Benh, and
>the bk tree and they all report the same error.  It looks like the drive
>is reporting that it doesn't have a DVD inserted, and fails to allow for
>the fact that CDROMS are valid.  As a side note I've also observed this
>error message on my G4 733 Tower with the superdrive.

This problem have been introduced by a change in the generic kernel
code that no longer does the necessary block size translation to mount
the 512 bytes block HFS filesystem from a 2048 bytes block CDROM device.

You have to mount it via the loopback device.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
