Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qxhlH3QkbzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Apr 2016 17:19:23 +1000 (AEST)
Subject: Re: radeonhd and xorg issues on powerpc p5020 and G5
To: luigi burdo <intermediadc@hotmail.com>
References: <DUB117-W972E5DAF4FC0B745E9B1F7C86F0@phx.gbl>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <57245A5D.6030101@daenzer.net>
Date: Sat, 30 Apr 2016 16:10:21 +0900
MIME-Version: 1.0
In-Reply-To: <DUB117-W972E5DAF4FC0B745E9B1F7C86F0@phx.gbl>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23.04.2016 02:06, luigi burdo wrote:
> 
> On Quad G5 with 2 video boards
> if i set radeon.modeset=1  nouveau.modeset=1 Xorg -configure dont found
> at all the video boards
> if i set radeon.modeset=0  nouveau.modeset=1 Xorg -configure dont found
> the nouveau board
> if i set radeon.modeset=1  nouveau.modeset=0 Xorg -configure dont found
> the radeon board

Xorg -configure has various known issues and shouldn't be used anymore.
Xorg is normally able to automatically detect and use all GPUs in a
system without any xorg.conf file.


> if i set radeon.modeset=0  nouveau.modeset=0 no video working ... no tty
> too ;-)

That disables both kernel drivers, which are required for fbcon and Xorg.


> On P5020
> last of my test is this machine with a  radeon hd 7770 core edition
> if radeon drv is running the system run in softpipe mode and i face many
> drm errors and fence issue.
> i atteched the dmesg files.

Which kernel version are you testing? There were some fixes in 4.4/4.5
which may help for the kernel driver issues, but note that the Mesa
radeonsi driver for >= 7xxx Radeons still needs a lot of work to be
usable on big endian systems.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
