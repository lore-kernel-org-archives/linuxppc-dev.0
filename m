Content-Type: text/plain;
  charset="iso-8859-1"
From: Robert Kaiser <rob@sysgo.com>
Reply-To: rkaiser@sysgo.com
To: "Mark Chambers" <markc@mail.com>,
	"Marius Groeger" <mgroeger@sysgo.com>
Subject: Re: Linux is not reliable enough?
Date: Tue, 27 Jul 2004 13:20:28 +0200
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <KCEOLLHGFJIAFNAMGACHMEMODPAA.k@kcomputing.com> <Pine.LNX.4.61.0407260940220.2134@mag.sysgo.com> <004701c47317$073ce590$0301a8c0@chuck2>
In-Reply-To: <004701c47317$073ce590$0301a8c0@chuck2>
MIME-Version: 1.0
Message-Id: <20040727112029.78C3699A6B@donald.sysgo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Am Montag, 26. Juli 2004 15:46 schrieb Mark Chambers:
> But if you write drivers that don't crash the system then
> linux is not unreliable.

Its not just the drivers: every line of kernel code (and there are over a
million of those in linux) has the potential to crash the system. In order to
be *really* sure that the system is reliable, one would have to give all that
code a thorough examination. Depending on how "thorough examination" is
defined (and there are approved standards for this), this effort results in
costs that quickly make the question wether the OS's source code is available
for free, or will cost a few hundred kilobucks, a non-issue.

> The only operating system that doesn't allow a
> clever programmer to crash is one that doesn't do anything.  Microkernels,
> they say, allow you to do nifty things like replace the file system without
> rebooting.

This is not really a microkernel-specific feature. I believe Linux with its
kernel modules can do this as well.

The important thing about the microkernel approach is that it allows to build
OS functionality from components, where each component runs in its own
address space and only has access to the resources it needs to do its job. A
device driver only needs access to the registers of the device it is supposed
to handle, so it can only foul up this particular device (*). If such a
driver goes haywire, it *can* not affect, e.g. other driver's hardware or
memory: the bug remains local to the software that causes it. Such a failure
affects only the offending component itself and the software modules that
rely on the services this component offers.

The benefit of this approach for safety-critical systems is that one can
identify the components that are critical to the application. If a particular
application does not require a big deal of OS functionality, then only the
few components necessary to implement it need to be scrutinized. Other
components may well exist in the system, for example to support non-critical
parts of the application, because they can not affect the critical parts.

Don't get me wrong: I'm not saying a microkernel (or even QNX) is inherently
safer than Linux. However, if done right, it can give you the freedom to
trade functional complexity against functional safety.

> So that means you could swap in a buggy filesystem and destroy
> the data on your disc/flash.  Without rebooting.  Which is good since you
> won't be able to boot from your corrupted filesystem, which won't show up
> until the next power failure, while the poor nurse with a flashlight talks
> to a guy on the phone who assures her QNX can't fail.  So every OS, and
> every feature, has its pro's and con's.  The question for any CSA is not
> 'is this reliable' but 'can I make a reliable system using this component'?
> Will the OS eat itself, or do I only have to worry about the mistakes I
> make?  A carefully constructed linux system should be good for 5 or even 6
> nines of reliability.

This may be your gut feeling, but the CSA has to *prove* it for the OS he
chooses (at least he should have to, that is his responsibility).

(Honestly: would you fly in an aircraft whose steer-by-wire system is
controlled by Linux/QNX/any other OS (name please)?)


Rob

(*) There are some more issues here which I left out for brevity: If the
device being handled by a driver is capable of DMA, it *can* crash
everything. Therefore, such drivers need special consideration. Also, for
memory-mapped I/O, access permissions to device registers need to be enforced
by the MMU, so, if there are multiple devices with their registers within the
same physical page, they can not be protected from each other. Nevertheless,
the likelihood if a wild pointer causing spurious crashes is still greatly
reduced.

----------------------------------------------------------------
Robert Kaiser                         email: rkaiser@sysgo.com
SYSGO AG
Am Pfaffenstein 14                    phone: (49) 6136 9948-762
D-55270 Klein-Winternheim / Germany   fax:   (49) 6136 9948-10


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
