Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 739DAB70B4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Jul 2010 09:01:19 +1000 (EST)
Message-ID: <4C4F6539.4000706@emcraft.com>
Date: Wed, 28 Jul 2010 03:01:13 +0400
From: Ilya Yanok <yanok@emcraft.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: mpc512x_dma hangs when used from multiple threads
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Piotr, everybody,

I've found that mpc512x_dma channels hang sometimes while accessed from 
more than one thread simultaneously.
The easiest way to reproduce this error I've managed to found is using 
dmatest module with rather high threads_per_chan value (20 should be 
enough):

-bash-3.2# insmod dmatest.ko max_channels=1 iterations=1 threads_per_chan=20
[   32.559568] dma0chan0-copy0: terminating after 1 tests, 0 failures 
(status 0)
-bash-3.2# [   35.553688] dma0chan0-copy1: #0: test timed out
[   35.558207] dma0chan0-copy1: terminating after 1 tests, 1 failures 
(status 0)
[   35.565458] dma0chan0-copy1: #0: test timed out
[   35.569968] dma0chan0-copy1: terminating after 1 tests, 1 failures 
(status 0)
[   35.577219] dma0chan0-copy1: #0: test timed out
[   35.581735] dma0chan0-copy1: terminating after 1 tests, 1 failures 
(status 0)
[   35.588953] dma0chan0-copy2: #0: test timed out
[   35.593502] dma0chan0-copy2: terminating after 1 tests, 1 failures 
(status 0)
[   35.600720] dma0chan0-copy3: #0: test timed out
[   35.605284] dma0chan0-copy3: terminating after 1 tests, 1 failures 
(status 0)
[   35.612472] dma0chan0-copy4: #0: test timed out
[   35.617052] dma0chan0-copy4: terminating after 1 tests, 1 failures 
(status 0)
[   35.624381] dma0chan0-copy5: #0: test timed out
[   35.628895] dma0chan0-copy5: terminating after 1 tests, 1 failures 
(status 0)
[   35.636126] dma0chan0-copy6: #0: test timed out
[   35.640657] dma0chan0-copy6: terminating after 1 tests, 1 failures 
(status 0)
[   35.647876] dma0chan0-copy7: #0: test timed out
[   35.652425] dma0chan0-copy7: terminating after 1 tests, 1 failures 
(status 0)
[   35.659643] dma0chan0-copy8: #0: test timed out
[   35.664209] dma0chan0-copy8: terminating after 1 tests, 1 failures 
(status 0)
[   35.671395] dma0chan0-copy9: #0: test timed out
[   35.675976] dma0chan0-copy9: terminating after 1 tests, 1 failures 
(status 0)
[   35.683164] dma0chan0-copy1: #0: test timed out
[   35.687743] dma0chan0-copy1: terminating after 1 tests, 1 failures 
(status 0)
[   35.694942] dma0chan0-copy1: #0: test timed out
[   35.699495] dma0chan0-copy1: terminating after 1 tests, 1 failures 
(status 0)
[   35.706714] dma0chan0-copy1: #0: test timed out
[   35.711264] dma0chan0-copy1: terminating after 1 tests, 1 failures 
(status 0)
[   35.719826] dma0chan0-copy1: #0: test timed out
[   35.724404] dma0chan0-copy1: terminating after 1 tests, 1 failures 
(status 0)
[   35.731549] dma0chan0-copy1: #0: test timed out
[   35.736131] dma0chan0-copy1: terminating after 1 tests, 1 failures 
(status 0)
[   35.744247] dma0chan0-copy1: #0: test timed out
[   35.748778] dma0chan0-copy1: terminating after 1 tests, 1 failures 
(status 0)
[   35.756768] dma0chan0-copy1: #0: test timed out
[   35.761301] dma0chan0-copy1: terminating after 1 tests, 1 failures 
(status 0)
[   35.769306] dma0chan0-copy1: #0: test timed out
[   35.773883] dma0chan0-copy1: terminating after 1 tests, 1 failures 
(status 0)

Also, this can be reproduced using more than one channel at once (in 
this case some of channels eventually hang). With max_channels=1 and 
threads_per_chan=1 dmatest works fine so I think this should be a 
synchronization issue.
After the hang, channel becomes unusable and cannot be even freed...

Is it a known problem? Maybe there exists some fix or workaround for it?

Regards, Ilya.
