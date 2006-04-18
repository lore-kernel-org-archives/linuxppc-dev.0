Return-Path: <tsawyer@broadcom.com>
Received: from sandmail.sandburst.com (sandmail.sandburst.com [216.57.132.42])
	by ozlabs.org (Postfix) with ESMTP id 87FD667A5A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Apr 2006 23:20:15 +1000 (EST)
Message-ID: <4444E01F.5000100@broadcom.com>
Date: Tue, 18 Apr 2006 08:48:31 -0400
From: "Travis B. Sawyer" <tsawyer@broadcom.com>
MIME-Version: 1.0
To: Andriy Korud <a.korud@vector.com.pl>
Subject: Re: CF card connection to PPC CPUs
References: <60E856FD577CC04BA3727AF4122D3F160106FDDB@3bit.vector.com.pl>
In-Reply-To: <60E856FD577CC04BA3727AF4122D3F160106FDDB@3bit.vector.com.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andriy Korud wrote:

>Hi,
>Does anybody has experience in connecting CF card to PPC (especially
>44x) CPU directly via EBC bus?
>I see how this can be done in TrueIDE mode, but unfortunately our
>application requires hot swap capability.
>
>  
>
Andriy:

We've done the direct connect route on a couple of our platforms 
(formerly Sandburst Metrobox).
Unfortunately, as you state, you lose HS caps.

We used two chip selects, and connected the bus as follows:

EBC Addr 28:30 <-> CF Addr 2:0

EBC Data   CF Data
8                    15
9                    14
10                  13
11                  12
12                  11
13                  10
14                  9
15                  8
0                    7
1                    6
2                    5
3                    4
4                    3
5                    2
6                    1
7                    0

/OE  & /CSEL are pulled down
/REG & /WE are pulled up.

Check out Das U-Boot Sandburst Metrobox (include/configs/METROBOX.h) for 
usage info.
We essentially used a technote/appnote from Toshiba (that I can't find 
right now).

Good luck,

travis
