Return-Path: <wd@denx.de>
Received: from mailout08.sul.t-online.com (mailout08.sul.t-online.com
	[194.25.134.20]) by ozlabs.org (Postfix) with ESMTP id D0CDE2BF10
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Dec 2004 11:23:26 +1100 (EST)
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 30 Dec 2004 17:27:53 EST."
	<313680C9A886D511A06000204840E1CF0A647439@whq-msgusr-02.pit.comms.marconi.com>
Date: Fri, 31 Dec 2004 00:08:34 +0100
Sender: wd@denx.de
Message-Id: <20041230230839.1A1B7C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: inflate returned FFFFFFFD - what does this error exactly mean ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Alex,

in message <313680C9A886D511A06000204840E1CF0A647439@whq-msgusr-02.pit.comms.marconi.com> you wrote:
> 
> After few days of wondering through debugging (and with great help) I fixed
> (by inserting watch dog resets into beginning of  while loops in zlib
> functions) my first problem -strange reboot failures during decompression of

You know why I recommended U-Boot :-)

> Now I am getting "controlled" failure (during the same decompression as
> described above):
> 
> I_BAD
> return Z_DATA_ERROR
> after zlib_inflate
> inflate returned FFFFFFFD
> exit
> 
> what does this error exactly mean ?

Most probably it means that the areas where the compressed  image  is
stored   and   to  where  you  copy  the  uncompressed  code  to  are
over-lapping. Try storing the compressed image at  a  higher  address
(like 0x400000 or so).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
How many seconds are there in a year? If I tell you there are 3.155 x
10^7, you won't even try to remember it. On the other hand, who could
forget that, to within half a percent, pi seconds is  a  nanocentury.
                                               -- Tom Duff, Bell Labs
