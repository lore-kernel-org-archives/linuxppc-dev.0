Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.62.0703261054180.8896@pademelon.sonytel.be>
References: <1174544624.10836.24.camel@localhost.localdomain>
	<94d8e19d4b061504fcfd08d1ab70cc78@kernel.crashing.org>
	<20070323120619.GA7472@localhost.localdomain>
	<94FD59E6-B618-4AB2-9BAB-D40A70CC1589@kernel.crashing.org>
	<b7160f3020aae6e7926b79c14939750c@kernel.crashing.org>
	<1174679208.10836.71.camel@localhost.localdomain>
	<6df7c98b19ded7a8a006e375255e3c3f@kernel.crashing.org>
	<Pine.LNX.4.62.0703261054180.8896@pademelon.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2900f15414598ecb5ebb6845f6defe86@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] force -mno-string option on cell
Date: Mon, 26 Mar 2007 14:33:07 +0200
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Akinobu Mita <mita@fixstars.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> strings instructions suck, get away with it.
>>
>> No they don't.
>>
>> End of this particular subthread I suppose, heh.
>
> Really? `They suck!' 'They don't!'...
>
> Ben: Why do they suck?
> Segher: Why don't they suck?

On most CPUs, they perform just fine, microcoded or not,
in most circumstances (hint: the bottleneck is not at the
decode stage).  They can actually help because of improved
code density.

For CPUs where they do suck, GCC knows (or should know)
preferably not to generate them.  Like on CBE, where lswi
causes a lovely 11-cycle bubble.  But guess what, many
more insns do so -- and we're not going to unconditionally
add a compiler flag to every kernel build that prevents
the compiler from generating "andi." insns I hope :-)


Segher
