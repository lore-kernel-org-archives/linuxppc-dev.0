Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <jetzdyttn0.fsf@sykes.suse.de>
References: <4898EE60.9080206@hypersurf.com> <200808061041.50577.jk@ozlabs.org>
	<48990D0F.6050909@hypersurf.com> <jetzdyttn0.fsf@sykes.suse.de>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CD567BB1-7207-4E8D-8970-B6BD925D56C7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: inline assembly & r0 SOS
Date: Wed, 6 Aug 2008 16:39:44 +0200
To: Andreas Schwab <schwab@suse.de>
Cc: linuxppc-dev@ozlabs.org, Kevin Diggs <kevdig@hypersurf.com>,
	Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> unsigned int get_PLL_range(unsigned int range, unsigned int config)
> {
>   range = range * 8 + 23;
>   return ((config << range) | (config >> (32 - range))) & 3;
> }
>
> The special pattern ((a << n) | (a >> (32 - n))) is recognized by  
> gcc as
> a rotate operation.

It's only valid for 1 <= n <= 31 though, so for input "range" 0 or 1.  
(*)
If that's the whole range needed, much simpler code is possible...


Segher

(*) or 0xffffffff or 0xfffffffe, but somehow I doubt that was intended.
