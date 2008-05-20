Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 May 2008 12:08:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 0/4] minor fixes for 2.6.26
Message-ID: <20080520020856.GH22279@yookeroo.seuss>
References: <1211136296-4572-1-git-send-email-galak@kernel.crashing.org>
	<0B367446-4628-4633-BF66-A0007BD9A98B@kernel.crashing.org>
	<18482.2082.900892.368978@cargo.ozlabs.ibm.com>
	<20080520005401.GD22279@yookeroo.seuss>
	<ec2c238ae4182d7546da3519fbf90158@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ec2c238ae4182d7546da3519fbf90158@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 20, 2008 at 04:03:47AM +0200, Segher Boessenkool wrote:
>>> I think that adding zImage.* to clean-files is a bad idea, because we
>>> have zImage.lds.S, zImage.coff.lds.S and zImage.ps3.lds.S in
>>> arch/powerpc/boot that we don't want deleted.  It would be OK for
>>> compiling with a separate object directory but would be bad for
>>> compiling in the source directory.
>>
>> Arguably this suggests we should rename either the lds files or the
>> zImages so that we *can* get a pattern to match.
>
> Not really.  Just define a $(ALL_ZIMAGES) var and use that everywhere.
> I would be pretty upset if "make clean" decided to delete my  
> zImage.backup,
> etc.

That won't work for .gitignore.  Besides it's hard to generate, since
zImage.<allsortsofthings> can be generated based on dts names.

Oh, and variables like that are usually a bad idea for clean rules,
because if new things have just been added/removed from the list, it
will fail to clean up things built before the makefile change was
made.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
