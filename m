To: Dan Malek <dan@netx4.com>
Cc: Pavel Roskin <pavel_roskin@geocities.com>,
        "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>,
        "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Software Emulation Exception...
References: <Pine.LNX.4.21.0004071011570.19406-100000@sunapee.transcept.com> <38EE0267.FB881499@embeddededge.com> <kfywvm6s3dz.fsf@kieraypc01.p.y.ki.era.ericsson.se> <38F200CF.B4A07187@embeddededge.com> <kfysnwtrpgn.fsf@kieraypc01.p.y.ki.era.ericsson.se> <38F315A7.AF8E0949@embeddededge.com>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 11 Apr 2000 16:51:23 +0200
In-Reply-To: Dan Malek's message of "Tue, 11 Apr 2000 08:08:07 -0400"
Message-ID: <kfyaej0snbo.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@netx4.com> writes:

> Marcus Sundberg wrote:
>
> > .... It has a 100% chance of crashing without the patch, and a 0%
> > chance of crashing with it.
>
> I agree the patch is necessary to fix a problem managing dirty
> pages......
>
> > All you have to do to experience the problem is allocate memory
> > until the RAM gets low
>
> ....but this wasn't the test....

I haven't seen any posts about "the test", but I doubt you can find
a better test for the dirty page bug.

> > .... If you are running a dynamicly linked glibc2
> > app what is most likely to happen is that the (dirty) jump table
> > is thrown out by the broken MM code.
>
> If, if, if......Is this really what is happening?

For me it is - I've watched the pte_val of a dirty page containg
the jump table change to zero (kernel throwing the page out), and
seen the crash when the page is being paged back in from disk.

Obviously I can't be sure about other peoples problems as I haven't
seen them happen, but if both the symptoms and the fix are identical
there is a good chance that the problem is the same as well.

>  I am concerned about proving a real problem and fixing it.
> If you aren't, that's OK.  I have other things to do.

A (serious) real problem has been found, and the fix is available.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
