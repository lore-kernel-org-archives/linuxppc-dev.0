Return-Path: <Andre.Schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 11AB4DDFBA
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 01:53:01 +1000 (EST)
Message-ID: <4821D059.7020808@matrix-vision.de>
Date: Wed, 07 May 2008 17:52:57 +0200
From: =?ISO-8859-1?Q?Andr=E9_Schwarz?= <Andre.Schwarz@matrix-vision.de>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [RFC] gianfar: low gigabit throughput
References: <20080506192008.GA30148@polina.dev.rtsoft.ru>
In-Reply-To: <20080506192008.GA30148@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton,

we've just built a digital GigEVision camera based on a MPC8343 running=20
at 266/400 csb/core speed.

Transmission is done from a kernel module that allocates skb into which=20
the image data is DMA'd by an external PCI master.
As soon as the image data is complete all buffers are sent out via=20
dev->hard_start_xmit ...

Bandwidth is currently 1.3MPixel @ 50Hz which give 65MBytes/sec=20
(~520MBit/s).
Of course it's UDP _without_ checksumming ....

Actually I have no sensor available that gives higher bandwidth ... but=20
having a look at transmission time I'm sure the MPC8343 can easily go up=20
to +800MBit.


Obviously your cpu time is consumed on a higher level.

Cheers,
Andr=E9


Anton Vorontsov wrote:
> Hi all,
>
> Down here few question regarding networking throughput, I would
> appreciate any thoughts or ideas.
>
> On the MPC8315E-RDB board (CPU at 400MHz, CSB at 133 MHz) I'm observing
> relatively low TCP throughput using gianfar driver...
>
> The maximum value I've seen with the current kernels is 142 Mb/s of TCP
> and 354 Mb/s of UDP (NAPI and interrupts coalescing enabled):
>
>   root@b1:~# netperf -l 10 -H 10.0.1.1 -t TCP_STREAM -- -m 32768 -s 157=
344 -S 157344
>   TCP STREAM TEST to 10.0.1.1
>   #Cpu utilization 0.10
>   Recv   Send    Send
>   Socket Socket  Message  Elapsed
>   Size   Size    Size     Time     Throughput
>   bytes  bytes   bytes    secs.    10^6bits/sec
>
>   206848 212992  32768    10.00     142.40
>
>   root@b1:~# netperf -l 10 -H 10.0.1.1 -t UDP_STREAM -- -m 32768 -s 157=
344 -S 157344
>   UDP UNIDIRECTIONAL SEND TEST to 10.0.1.1
>   #Cpu utilization 100.00
>   Socket  Message  Elapsed      Messages
>   Size    Size     Time         Okay Errors   Throughput
>   bytes   bytes    secs            #      #   10^6bits/sec
>
>   212992   32768   10.00       13539      0     354.84
>   206848           10.00       13539            354.84
>
>
> Is this normal?
>
> netperf running in loopback gives me 329 Mb/s of TCP throughput:
>
>   root@b1:~# netperf -l 10 -H 127.0.0.1 -t TCP_STREAM -- -m 32768 -s 15=
7344 -S 157344
>   TCP STREAM TEST to 127.0.0.1
>   #Cpu utilization 100.00
>   #Cpu utilization 100.00
>   Recv   Send    Send
>   Socket Socket  Message  Elapsed
>   Size   Size    Size     Time     Throughput
>   bytes  bytes   bytes    secs.    10^6bits/sec
>
>   212992 212992  32768    10.00     329.60
>
>
> May I consider this as a something that is close to the Linux'
> theoretical maximum for this setup? Or this isn't reliable test?
>
>
> I can compare with teh MPC8377E-RDB (very similar board - exactly the s=
ame
> ethernet phy, the same drivers are used, i.e. everything is the same fr=
om
> the ethernet stand point), but running at 666 MHz, CSB at 333MHz:
>
>          |CPU MHz|BUS MHz|UDP Mb/s|TCP Mb/s|
>   ------------------------------------------
>   MPC8377|    666|    333|     646|     264|
>   MPC8315|    400|    133|     354|     142|
>   ------------------------------------------
>   RATIO  |    1.6|    2.5|     1.8|     1.8|
>
> It seems that things are really dependant on the CPU/CSB speed.
>
> I've tried to tune gianfar driver in various ways... and it gave
> some positive results with this patch:
>
> diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h
> index fd487be..b5943f9 100644
> --- a/drivers/net/gianfar.h
> +++ b/drivers/net/gianfar.h
> @@ -123,8 +123,8 @@ extern const char gfar_driver_version[];
>  #define GFAR_10_TIME    25600
> =20
>  #define DEFAULT_TX_COALESCE 1
> -#define DEFAULT_TXCOUNT	16
> -#define DEFAULT_TXTIME	21
> +#define DEFAULT_TXCOUNT	80
> +#define DEFAULT_TXTIME	105
> =20
>  #define DEFAULT_RXTIME	21
>
>
> Basically this raises the tx interrupts coalescing threshold (raising
> it more didn't help, as well as didn't help raising rx thresholds).
> Now:
>
> root@b1:~# netperf -l 3 -H 10.0.1.1 -t TCP_STREAM -- -m 32768 -s 157344=
 -S 157344
> TCP STREAM TEST to 10.0.1.1
> #Cpu utilization 100.00
> Recv   Send    Send
> Socket Socket  Message  Elapsed
> Size   Size    Size     Time     Throughput
> bytes  bytes   bytes    secs.    10^6bits/sec
>
> 206848 212992  32768    3.00      163.04
>
>
> That is +21 Mb/s (14% up). Not fantastic, but good anyway.
>
> As expected, the latency increased too:
>
> Before the patch:
>
> --- 10.0.1.1 ping statistics ---
> 20 packets transmitted, 20 received, 0% packet loss, time 18997ms
> rtt min/avg/max/mdev =3D 0.108/0.124/0.173/0.022 ms
>
> After:
>
> --- 10.0.1.1 ping statistics ---
> 22 packets transmitted, 22 received, 0% packet loss, time 20997ms
> rtt min/avg/max/mdev =3D 0.158/0.167/0.182/0.004 ms
>
>
> 34% up... heh. Should we sacrifice the latency in favour of throughput?
> Is 34% latency growth bad thing? What is worse, lose 21 Mb/s or 34% of
> latency? ;-)
>
>
> Thanks in advance,
>
> p.s. Btw, the patch above helps even better on the on the -rt kernels,
> since on the -rt kernels the throughput is near 100 Mb/s, with the
> patch the throughput is close to 140 Mb/s.
>
>  =20


MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht: Amtsgericht Stuttgart, HRB 271090
Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
