Date: Fri, 9 Feb 2001 00:28:41 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: David Edelsohn <dje@watson.ibm.com>
cc: Cort Dougan <cort@fsmlabs.com>, paulus@linuxcare.com.au,
        Dan Malek <dan@mvista.com>, tom_gall@vnet.ibm.com,
        linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow 
In-Reply-To: <200102082208.RAA22218@mal-ach.watson.ibm.com>
Message-ID: <Pine.HPX.4.10.10102090003130.15466-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 8 Feb 2001, David Edelsohn wrote:

> 	"Your paper discussess an approach to handling hash table misses
> quickly, but that begs the question of why your design has so many hash
> table misses that it is important to handle them quickly.  In the Research
> OS that I am working on (targetting PowerPC architecture, among others),
> we assume that hash table misses are so infrequent, that we handle them as
> in-core page faults.  With a hash table 4 times the size of physical
> memory, and a good spread of entries across them, this seems reasonable.  I
> got the impression that misses in your system are more frequent because
> you allocate new VSIDs rather than unmap multiple pages from the page
> table.  If so, I guess that you can't be exploiting the dirty bit in the
> page/hash table entry, and hence get double misses on write faults.
>
> 	"We also disagree with one of your main conclusions: that
> processors should not handle TLB misses in HW.  I think that software
> handling of TLB misses is an idea whose time as come ... and gone :-)
> Hardware made sense in the past when you wanted to look at a whole pile of
> entiries at the same time with specialized HW.  Then, for a while it was
> more efficient to do things in SW and avoid the HW complexity.  Now, with
> speculative execution and super-scaler highly pipelined processors,
> handling them in SW means that you suffer a huge performance penalty
> because you introduce a barrier/bubble on every TLB miss.  With HW you can
> freeze the pipeline and handle the miss with much reduced cost."
>
> 	You and Paul and Victor did some excellent work, but you need to
> keep in mind what implicit assumptions about processor design determined
> whether the VMM design was an overall win.  We can have a discussion about
> whether the hardware improvements which make the VMM design less
> adventageous are themselves the right strategy, but many commercial
> processors are following that path after careful study of all options.
>
> 	Your VMM design was correct for a specific, narrow class of
> processors.  We do not agree with your premise that the criteria for a
> good processor design is whether it can utilize your VMM design.
>
> 	As I said before, one needs to consider the microarchitecture
> design and implementation of new processors before one can make sweeping
> statements about which VMM design is best.  You can create a wonderful
> engineer solution, but are you solving the problem or simply masking a
> symptom?

I agree with you, but that's only a gut feeling. Did you also notice that
Linux/PPC only uses half the recommended hash table size unless I'm
grossly mistaken ?

My feeling is that the hash table should be rather over- than under-sized,
especially with the amount of sharing there is between all the
applications running on "modern" desktops (large shared libraries for
X/KDE/GNOME among other things).

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
