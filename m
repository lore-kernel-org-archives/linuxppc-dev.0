Return-Path: <michel@tungstengraphics.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by ozlabs.org (Postfix) with ESMTP id 6B881DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 01:56:32 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so1807018fgg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 06:56:30 -0800 (PST)
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1200659696.23161.81.camel@thor.sulgenrain.local>
References: <1200659696.23161.81.camel@thor.sulgenrain.local>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Jan 2008 15:56:26 +0100
Message-Id: <1201013786.4726.28.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-01-18 at 13:34 +0100, Michel Dänzer wrote:
> This is on a PowerBook5,8.
> 
> In a nutshell, things seem more sluggish in general than with 2.6.23.
> But in particular, processes running at nice levels >0 can get most of
> the CPU cycles available, slowing down processes running at nice level
> 0.

The canonical test case I've come up with is to run an infinite loop
with

sudo -u nobody nice -n 19 sh -c 'while true; do true; done'

This makes my X session (X server running at nice level -1, clients at
0) unusably sluggish (it can even take several seconds to process ctrl-c
to interrupt the infinite loop) with 2.6.24-rc but works as expected
with 2.6.23.

Anybody else seeing this?


> I've seen this since .24-rc5 (the first .24-rc I tried), and it's still
> there with -rc8. I'd be surprised if this kind of behaviour remained
> unfixed for that long if it affected x86, so  I presume it's powerpc
> specific.

Or maybe not... I've bisected this down to the scheduler changes between
df3d80f5a5c74168be42788364d13cf6c83c7b9c/23fd50450a34f2558070ceabb0bfebc1c9604af5 and b5869ce7f68b233ceb81465a7644be0d9a5f3dbb . I'll try and bisect it further, but this is my main work machine, so I can't reboot it too often. I'm CC'ing Ingo in case he has any ideas offhand.


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
