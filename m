Return-Path: <i@coly.li>
Received: from oproxy3-pub.bluehost.com (oproxy3-pub.bluehost.com [69.89.21.8])
	by ozlabs.org (Postfix) with SMTP id 3940BB7106
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Jan 2011 21:36:21 +1100 (EST)
Message-ID: <4D42A23B.4090302@coly.li>
Date: Fri, 28 Jan 2011 19:02:19 +0800
From: Coly Li <i@coly.li>
MIME-Version: 1.0
To: Andreas Schwab <schwab@redhat.com>
Subject: Re: [PATCH 2/7] PowerPC: add unlikely() to BUG_ON()
References: <4D41B213.4070606@caviumnetworks.com>	<AE90C24D6B3A694183C094C60CF0A2F6D8AC2D__37237.0892241181$1296205746$gmane$org@saturn3.aculab.com>
	<m31v3xxrlz.fsf@redhat.com>
In-Reply-To: <m31v3xxrlz.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Coly Li <bosong.ly@taobao.com>,
	David Daney <ddaney@caviumnetworks.com>,
	linux-kernel@vger.kernel.org, Yong Zhang <yong.zhang0@gmail.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Wang Cong <xiyou.wangcong@gmail.com>, linuxppc-dev@lists.ozlabs.org
Reply-To: i@coly.li
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2011年01月28日 18:14, Andreas Schwab Wrote:
> "David Laight"<David.Laight@ACULAB.COM>  writes:
>
>> Also, as (I think) in some of the generated code quoted,
>> use of __builtin_expect() with a boolean expression can
>> force some versions of gcc to generate the integer
>> value of the expression
>
> That's more likely a side effect of the definition of likely/unlikely:
> they expand to !!(x).
>

It seems whether or not using unlikely() inside arch implemented BUG_ON() is arch dependent. Maybe a reasonable method 
to use BUG_ON() is,
1) do not explicitly use unlikely() when using macro BUG_ON().
2) whether or not using unlikely() inside BUG_ON(), it depends on the implementation of BUG_ON(), including arch 
implementation.

So from current feed back, doing "unlikely() optimization" here doesn't make anything better.

Thanks for all of your feed back :-)

-- 
Coly Li
