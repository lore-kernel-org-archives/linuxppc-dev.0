Date: Wed, 20 Sep 2000 19:24:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: CPU Temperature Patch
Message-ID: <20000920192432.T472@opus.bloom.county>
References: <20000920110436.C15401@opus.bloom.county> <Pine.LNX.4.10.10009202113230.7561-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10009202113230.7561-100000@opal.biophys.uni-duesseldorf.de>; from schmitz@opal.biophys.uni-duesseldorf.de on Wed, Sep 20, 2000 at 09:15:27PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Sep 20, 2000 at 09:15:27PM +0200, Michael Schmitz wrote:
> > > > +       /* this set for 500 MHz Pismo - how do we get access to clock?? */
> > >
> > > There is, in the same file, around line 319 code to read the clock speed from
> > > the device tree. However, is it really necessary to include the clock speed at
> > > this point? What is the drawback if we just assume 500 MHz (or even the max
> > > value) for every G3 based machine?
> >
> > Why assume when we can do it properly?  Besides, a friend of mine oc'ed his
> > B&W to 550, so it's possible to have >500Mhz :)
>
> Like this?

Looks almost sane.

> @@ -208,9 +209,23 @@
>  	/* we need 20us to do the compare - assume 300MHz processor clock */
>  	/* max value for sitv is 0x3fff - or 16383 */
>  	/* this set for 500 MHz Pismo - how do we get access to clock?? */
> +
> +	cpu_freq = 500;

But why 500 here?  The bit for reading temp is on all G3s, yes?  And since
we assume 300Mhz clock, which is the middle of the clock ranges (close enough)
shouldn't this be 300 as well?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
