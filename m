Message-ID: <005201c2f271$e1e199c0$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Tom Rini" <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>,
	<strauman@SLAC.Stanford.EDU>
References: <IGEFJKJNHJDCBKALBJLLEEGBFLAA.joakim.tjernlund@lumentis.se> <20030324201543.GB14264@ip68-0-152-218.tc.ph.cox.net> <006601c2f256$e6ff5e80$020120b0@jockeXP> <3E7F9017.2000900@embeddededge.com> <000b01c2f261$292427a0$020120b0@jockeXP> <3E7FA758.20808@embeddededge.com>
Subject: Re: dcbz works on 862 everywhere!
Date: Tue, 25 Mar 2003 02:57:18 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
>
> > Did you read my mails?
>
> I did.  From this I gathered that you don't understand why some
> of this code is there in the first place, you removed code that

No I don't understand this code fully. I don't think anybody but you understand
this code since it contains undocumented workarounds.
I asked the list before I removed it. Had you objected before I got to the
patch I had left it alone. It was just a test.

> would have guaranteed to cause an error if you would have run
> the proper test, and you can't explain why the changes you made
> cause the results you see.

But I can explain(didn't I do that earlier?). We agree that dcxx will
cause DTLB Misses without setting DAR, right?. By copying the MD_EPN to
DAR before rfi, DAR will have address whose EPN is correct but with a
semirandom page offset(the last bits in MD_EPN that doesn't referrer to
the EPN). This must be better than just leaving dar as is, especially if
rfi needs a valid addess to operate properly as you write below.

The second part:
+ /* Copy 20 msb from EPN to DAR since the dcxx instuctions fails
+  * update the DAR when they cause a DTLB Miss.
+  */
+ mfspr r21, MD_EPN
+ rlwinm r21, r21, 0, 0, 19
+ mfspr r20, DAR
+ rlwinm r20, r20, 0, 20, 31
+ or r20, r20, r21
+ mtspr DAR, r20

Just replaces the EPN part to generate a valid address within the page. The lower bits
are untouched. This is a nop if DAR already contains the right address, otherwise DAR
will at least contain a valid page address.

This could be move to before error test if you want play safe(the 2 instructions before
rfi should be removed in this case)

> Not something that instills much confidence.

After the above explanation I hope that will improve somewhat.

>
> All of these MMU and cache control registers have effects on
> one another.  Writing one register can have the side effect of
> updating another.  The DAR must have valid addresses in order
> to properly rfi, we know some cache operations may not set this
> properly, and we also know that in these cases the MD_EPN is also
> not set properly.
If MD_EPN is not set propely in the DTLB Miss, you are lost regardless of
my patch.

[SNIP]
> For a long time, we "solved" these problems on 8xx by not properly
> implementing copy-on-write pages and always marking pages dirty.
> It reduced the likelyhood of the problem, reduced the MMU overhead,
> but cost lots more in memory and processing time during forks.
> This still may not be a bad configuration option for selected
> applications.

Is it easy to patch/hard code? I would like to test the stability of my system.

> Like I said from the beginning, the 100% guaranteed working solution
> is to not use dcbz/dcbt on the 8xx.  Anything else will eventually
> stumble across the error conditions.  If I'm developing a product
> that uses Linux (or any other OS that will dynamically update the MMU
> and take DTLB exceptions) I won't take the risk of failure using
> these instructions.

I still that the patch to head_8xx.S has merit on its own. It will workaround
the case where DAR has an invalid value in the DTLB Miss handler.

Still, it would be nice if you could give the patch a go in your lab(with recent silicon).

Time to sleep for me
                                    Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
