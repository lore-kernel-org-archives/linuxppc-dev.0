Subject: Re: TLB and CSSBAR problems with MPC8540 and BDI2000
From: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
To: Dan Malek <dan@embeddededge.com>
Cc: fabidi@ultsol.com, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3FFEEAD9.80308@embeddededge.com>
References: 
	 <704F2B356FCC3E49A909C625BD9E5C4002143D@ultsol01.tewks.ultsol.local>
	 <3FFEEAD9.80308@embeddededge.com>
Content-Type: text/plain
Message-Id: <1073677509.10794.14.camel@chuck.arlut.utexas.edu>
Mime-Version: 1.0
Date: Fri, 09 Jan 2004 13:45:09 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 So more specifically, if the bdi2000 init section moves the CCSRBAR and
maps a TLB to the location the CCSRBAR was moved too you can't just
moved the CCSRBAR back to its default location? One would also need to
remap the TLB entry to CCSRBAR?

        Could anyone familiar with that workaround listed below verify
that
this could be causing the CPU to freeze/crash?

Thanks,
Matthew

On Fri, 2004-01-09 at 11:54, Dan Malek wrote:
> Fahd Abidi wrote:
>
> > I think my problem is all centered around TLB's and the CCSRBAR.
>
> Yes, it is.
>
> The debug control registers are part of the CCSRBAR space.  The
> BDI2000 tracks modifications it makes if the space is moved, however,
> if your software moves that space the BDI2000 doesn't know it and
> can't access the registers.
>
> If you are debugging code, like u-boot here, you have to make
> several code modifications so the CCSR space isn't moved during your
> debugging (among other things).
>
>
> 	-- Dan
>
>
--
Matthew S. McClintock <mattsm@arlut.utexas.edu>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
