Date: Wed, 25 Aug 2004 10:40:59 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Oliver King-Smith <oliver.king-smith@nuvation.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem trying to address custom hardware
Message-ID: <20040825104059.B9986@home.com>
References: <FC3C0DD86B79DF4FA423AF0379A547610155436D@mailguy2.nuvation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FC3C0DD86B79DF4FA423AF0379A547610155436D@mailguy2.nuvation.com>; from oliver.king-smith@nuvation.com on Tue, Aug 24, 2004 at 04:10:15PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[your mailer is really bad and should be fixed, this required heavy editing]

On Tue, Aug 24, 2004 at 04:10:15PM -0700, Oliver King-Smith wrote:
> memfd = open("/dev/mem", O_RDWR);
> if (memfd){
>  pCPLD = (CPLD_REGISTERS *) mmap(0,
>  CPLD_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE,
>  memfd, CPLD_OFFSET);

Others addressed your core problem, but you should know that this
mmap request won't produce the desired result. You need MAP_SHARED
since MAP_PRIVATE will result in a COW when you attempt to modify
your register.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
