Date: Thu, 06 Apr 2000 15:27:11 +0100
Subject: Re: Setting up yaboot
From: Mark Steer <mark@insanely-great.co.uk>
To: Ethan Benson <erbenson@alaska.net>
CC: Olaf Hering <olh@suse.de>, <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B5125D4F.C4F%mark@insanely-great.co.uk>
In-Reply-To: <20000406054042.E2099@plato.localdomain.local>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


on 6/4/2000 2:40 pm, Ethan Benson at erbenson@alaska.net wrote:

> On Thu, Apr 06, 2000 at 02:23:38PM +0100, Mark Steer wrote:
>
>> I've recently setup my new Pismo/400 with Linux and, as of this morning,
>> Darwin 1.0 and I think I'm going to require a hard drive upgrade about 6
>> months sooner than I'd planned for...
>
> ;-)
>
>> I can confirm that you do need to add the PowerBook3,1 line into the
>> <COMPATIBLE> section before the Pismo will use the os chooser script
>> correctly.
>
> thought so...
>
>> One thing I noticed, at least with this machine, is that the line:-
>>
>> boot hd:10,\\yaboot
>>
>> will fail unless I rewrite it as:-
>>
>> boot hd:10,yaboot
>
> that line means boot yaboot from the root directory, certianly the
> most reliable method i have found other then hd:,\\:tbxi (which only
> works on CHRP scripts with a properly blessed directory)
>
> the first notation means to load the file from the blessed directory,
> which if there isn't one will fail.  macos tends to remove the
> blessing from non-macos directories.
>

Ah! thank you, that clears it up.  I haven't bothered to set a system folder
on my HFS exchange disk. [Thanks also to BenH for that information.]


>> This is the first new world machine that I have setup with Linux so I don't
>> know if this is right for others or if my configuration may be different.
>> I'm going to be upgrading :-) an iMac DV with Linux this afternoon so I'll
>> report back what that one does with regard to the os chooser script.
>>
>> Now I'm off to try and rewrite the script so that I can choose Darwin as
>> well...
>
> does darwin still use UFS or ffs for its default filesystem?

The Darwin binary that I downloaded installs onto an HFS+ volume from an
image (darwin.img) using the Apple Software Restore utility.  In my case the
supplied version of the Software Restore utility failed each time it was
started(error: can't locate HID, I think) and I had to use the one that came
with my system restore CD.

> if so it probably uses a bootstrap partition of type Apple_Bootstrap or
> Apple_BootROM setup pretty much the same way i advocate (that is where
> i got the idea, from OSX server) if it does still use this partition
> you should be able to add a reference to it like so:
>
> hd:6,\\:tbxi
>
> to your chooser script.  where 6 is the real partition number of the
> darwin bootstrap partition.

Yes, that's it.  The System Disk utility (version 3 is supplied) showed me
the info that it writes into OF, giving me enough info to modify the script.
In my case hd:13,\\:tbxi

I think that's just too many partitions :-)


Regards,
       Mark Steer.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
