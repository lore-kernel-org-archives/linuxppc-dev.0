Message-ID: <40049EAA.6030709@embeddededge.com>
Date: Tue, 13 Jan 2004 20:43:06 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
Cc: fabidi@ultsol.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: TLB and CSSBAR problems with MPC8540 and BDI2000
References: <704F2B356FCC3E49A909C625BD9E5C4002143D@ultsol01.tewks.ultsol.local>	 <3FFEEAD9.80308@embeddededge.com>	 <1073677509.10794.14.camel@chuck.arlut.utexas.edu>	 <3FFF276C.4060003@embeddededge.com>	 <1073686698.3275.10.camel@chuck.arlut.utexas.edu>	 <3FFF2B00.6@embeddededge.com>  <4002C3BB.8060805@embeddededge.com> <1073938758.5575.140.camel@chuck.arlut.utexas.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matthew S. McClintock wrote:

> So that leaves us back at the original question. Why does configuring
> the cpu via bdi2000 prevent me from using my u-boot image? Any other
> ideas?

Yep.  I have one now.  Make sure your u-boot image also has a TLB1
entry for your "default" CCSRBAR.  Further, make sure your BDI init
section doesn't move the CCSRBAR from the default value assumed by
your u-boot image.  I had the latter correct, just didn't realize
that a "TLB1 flash invalidate" command to the MMUCSR0 doesn't seem
to honor the 'invalidate protect' in the TLB entry.  Everything
works fine when you get all of the ducks in a row :-)

Of course, we should be discussing this on the u-boot list,
not on this one........


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
