To: Paul.Mackerras@cs.anu.edu.au
Cc: Geert.Uytterhoeven@cs.kuleuven.ac.be, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu, rth@cygnus.com
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
References: <Pine.LNX.4.10.9908091008460.25523-100000@mercator.cs.kuleuven.ac.be> <199908100100.LAA28784@tango.anu.edu.au> <d34si8xfwi.fsf@lxp03.cern.ch> <199908110023.KAA23996@tango.anu.edu.au>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
Date: 11 Aug 1999 09:23:29 +0200
In-Reply-To: Paul Mackerras's message of "Wed, 11 Aug 1999 10:23:46 +1000"
Message-ID: <d34si6kcge.fsf@lxp03.cern.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Paul" == Paul Mackerras <paulus@cs.anu.edu.au> writes:

Paul> Jes Sorensen <Jes.Sorensen@cern.ch> wrote:
>> This is quite easily solved by putting in mb()'s in the right
>> places. This is how it is done for other drivers that are supposed
>> to work on the Alpha.

Paul> No, this is not an acceptable solution.

Paul> On ultrasparc at least, there is a "side-effect" bit in each
Paul> PTE.  If that bit is set, it tells the cpu not to reorder
Paul> accesses to that page.  I don't know whether alpha has the same
Paul> facility, do you?

No idea but I bet Richard Henderson can answer that question. I also
checked with him after posting this message yesterday and the answer
was readl/writel are not supposed to guarantee strict ordering.

Paul> Anyway, it's hard enough educating device driver writers about
Paul> the need for byte-swapping on data in memory that is accessed by
Paul> DMA.  Trying to get people to scatter mb()'s around their
Paul> drivers would be a herculean task (a bit like cleaning out the
Paul> Augean stables, actually :-).

There are quite a few issues device driver authors needs to deal with,
this is just one of them. I actually made quite an effort to explain
the problem in my tutorial at Linux Expo. Besides people still have to
deal with it when writing drivers for devices that are not mapped in
PCI space but directly mapped. Having readl/writel guarantee ordering
is inconsistant.

Paul> Finally, mb() is actually a much stronger constraint than we
Paul> need in a device driver, and will slow things down
Paul> unnecessarily.  mb() implies a strong ordering on all loads and
Paul> stores to all memory.  On the PPC, mb() translates into the sync
Paul> instruction, which is much slower than eieio.  For a sync, the
Paul> cpu actually has to stop and wait for all bus activity to
Paul> complete, whereas for an eieio, it just puts a special kind of
Paul> entry in the stream of accesses going out to the memory bus.

I don't know enough about the PPC architecture to comment on this,
however I can see that wmb() translates into an eieio. wmb() is more
fine grained and it would make sense to promote it over plain mb() in
the places where it makes sense.

>> Having mb()'s explicitly put into the driver in the right places
>> also makes sure that a driver will work on other
>> architectures. Right now a driver that is written for the PPC is
>> likely not to work on the Alpha if the author expects readl/writel
>> to guarantee write ordering.

Paul> Well, if alpha is actually like that, then IMO it is broken.

I will have to disagree with you on this one, I consider the PPC
implementation to be very broken in this regard.

Paul> So, unless and until you can show me some numbers that show an
Paul> actual performance degradation from having the eieio in
Paul> readl/writel, the eieio stays.

So will the education of people telling them to use mb() after
writel() if they want to be sure of the result.

Jes

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
