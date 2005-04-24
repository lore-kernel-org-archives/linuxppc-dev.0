Return-Path: <wd@denx.de>
Received: from mailout07.sul.t-online.com (mailout07.sul.t-online.com
	[194.25.134.83]) by ozlabs.org (Postfix) with ESMTP id 9DB4B67B25
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Apr 2005 08:51:41 +1000 (EST)
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 24 Apr 2005 14:25:18 -0300."
	<20050424172518.GB22786@logos.cnet>
Date: Mon, 25 Apr 2005 00:51:19 +0200
Sender: wd@denx.de
Message-Id: <20050424225124.E7314C1510@atlas.denx.de>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: v2.6 performance slowdown on MPC8xx: Measuring TLB cache misses
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Marcelo,

in message <20050424172518.GB22786@logos.cnet> you wrote:
> 
> Others have mentioned, and I agree, that sysfs is likely to be the major 
> cause for boot-time slowdown. Have you tried disabling sysfs? 

No, not yet.

> Question: Such huge regressions are seen on MPC8xx only, MPC82xx slowdown 
> is not so bad, correct? 

No. You can find both the LMBENCH summar and the raw data at
http://www.denx.de/twiki/pub/Know/Linux24vs26/lmbench_results resp.
http://www.denx.de/twiki/pub/Know/Linux24vs26/lmbench_results_raw.tar.gz

In most cases the MPC8240 is as bad as the  MPC860;  just  for  local
communication   bandwidth  there  is  a  visible  dependency  on  the
processor: pipes are faster on 8240 but much slower (49%) on the 860,
but the UNIX sockets are 11% slower on 8240 while we  get  about  the
same speed as with 2.4 on the 860, etc.

Here is the context switching part:

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
sp8240     Linux 2.4.25         200.4   69.0  217.1   78.1   219.9    78.5
sp8240     Linux 2.4.25         207.5   63.4  229.9   93.7   230.8    81.1
sp8240     Linux 2.4.25         207.4   72.4  230.6   89.5   233.9    86.3
sp8240    Linux 2.6.11. 8.9400  254.1  143.0  261.3  161.3   259.4   160.6
sp8240    Linux 2.6.11. 8.5100  234.4  127.4  256.4  161.4   251.3   149.0
sp8240    Linux 2.6.11. 8.5400  211.8  128.0  240.2  157.7   243.7   153.9
tqm8xx     Linux 2.4.25   29.4   64.7          78.4           81.6        
tqm8xx     Linux 2.4.25   32.9   56.5          75.8           80.0        
tqm8xx     Linux 2.4.25   29.9   66.7          76.6           80.8        
tqm8xx    Linux 2.6.11.   44.7   90.3         132.1          131.3        
tqm8xx    Linux 2.6.11.   48.8  117.1         132.7          136.6        
tqm8xx    Linux 2.6.11.   47.6   90.7         126.7          133.1        

and the local comm latencies:

*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
sp8240     Linux 2.4.25        46.5 120. 522.5 1362. 842.1 1817. 2828
sp8240     Linux 2.4.25        47.1 135. 504.6 1330. 880.2 1838. 2774
sp8240     Linux 2.4.25        47.1 134. 535.2 1369. 855.4 1810. 2929
sp8240    Linux 2.6.11. 8.940  89.4 251. 683.0 1506. 1020. 2021. 3507
sp8240    Linux 2.6.11. 8.510  89.5 251. 701.7 1500. 1075. 2032. 3492
sp8240    Linux 2.6.11. 8.540  88.2 263. 703.1 1550. 1110. 2076. 3588
tqm8xx     Linux 2.4.25  29.4 145.3 309. 682.3 1427. 1000. 1896. 2992
tqm8xx     Linux 2.4.25  32.9 144.3 338. 675.9 1434. 1002. 1933. 2990
tqm8xx     Linux 2.4.25  29.9 150.5 352. 679.4 1429. 1006. 1931. 2983
tqm8xx    Linux 2.6.11.  44.7 238.8 522. 940.4 1629. 1265. 2125. 3792
tqm8xx    Linux 2.6.11.  48.8 255.2 531.             1255.       3750
tqm8xx    Linux 2.6.11.  47.6 258.6 550.             1252.       3783

Actually the 8240 is worse than the 860 in some of the tests...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Man did not weave the web of life; he  is  merely  a  strand  in  it.
Whatever he does to the web, he does to himself.     - Seattle [1854]
