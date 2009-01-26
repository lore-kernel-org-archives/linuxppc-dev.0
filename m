Return-Path: <dgibson@ozlabs.org>
Date: Tue, 27 Jan 2009 10:20:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Ebony DTS compile error
Message-ID: <20090126232028.GB10495@yookeroo.seuss>
References: <e4ef24880901231707y7baad5f6kc1f6bde2c30bf29f@mail.gmail.com>
	<20090124014701.71561832E425@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090124014701.71561832E425@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, Rob Gubler <rgubler@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 24, 2009 at 02:47:01AM +0100, Wolfgang Denk wrote:
> Dear Rob Gubler,
> 
> in message <e4ef24880901231707y7baad5f6kc1f6bde2c30bf29f@mail.gmail.com> you wrote:
> >
> > I'm an ELDK 4.2 user.  I'm trying to compile the ebony.dts file included in
> > the 2.6.24 kernel but the Device Tree Compiler, dtc, complains of a syntax
> > error.
> 
> Yes, there is a version conflict. The 2.6.24 kernel still uses an old
> dts format, which is incompatible with recent dtc versiosn.

Yes, that's right.  Support for the old dts-v0 format was removed in
recent upstream dtc versions.  The dts file you have is too new for
the very old ELDK dtc, but too old for current dtc.

Hey jdl, this sort of case is why I was always against removing dts-v0
support.

> > Is anyone aware of a version of DTC that will compile the ebony.dts file
> > included with the 2.6.24 kernel?  Or, an updated ebony.dts file that works
> > with DTC 1.2.0-gb2b4990b.  Any other suggestions would be great.  Thanks!
> 
> Is there any specific reson for you to use the old 2.6.24 kernel?
> 
> If not, I'd recommend that you clone the git repository and use recent
> code - this will build fine with current versions of the dtc.

I concur.  If you really have to use the old kernel, you could
manually update the dts to dts-v1 without making other changes, which
should be relatively simple - that's just a matter of changing all
numbers in the file from bare hex to C-style (decimal by default, 0x
for hex, etc.) and adding the magic /dts-v1/ tag at the top.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
