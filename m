Message-ID: <015501c3deef$27263030$9104050a@JACKYLAM>
From: "Jacky Lam" <jackylam@astri.org>
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <00b101c3de3e$9c34f200$9104050a@JACKYLAM> <20040119052806.GA26841@gate.ebshome.net>
Subject: Re: Small UDP packet performance
Date: Tue, 20 Jan 2004 08:48:38 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Thanks. My case is that I am using NetPerf to test the UDP performance.
I am using a x86 with GigaEthernet card and sending packet to my 405EP in
full speed. I find that the box nearly dead in first min and lost all
packets. I know that it is unavoidable. But I want to know anyway to improve
as much as possible.

    What is NAPI? How can I make use of it? Is there any buffer size in UDP
stack that I can adjust? Thanks.

Jacky
----- Original Message -----
From: "Eugene Surovegin" <ebs@ebshome.net>
To: "Jacky Lam" <jackylam@astri.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Monday, January 19, 2004 1:28 PM
Subject: Re: Small UDP packet performance


> On Mon, Jan 19, 2004 at 11:44:55AM +0800, Jacky Lam wrote:
> >     Currently, I find that my PPC 405EP board has some problem about the
> > throughput of small UDP packet (188 bytes). The throughput is just only
> > ~0.01%. However, for large packet, say 1K, the throughput is very good.
It
> > is more than 50%. Is it a problem of PPC Linux, ethernet driver or
generic
> > Linux? Is there any way to tune it? Thanks.
>
> When talking about IP stack/driver performance usually you should pay
> attention to the packets per second (pps) not throughput (whatever you
> mean under this term).
>
> If you analyze your test cases using pps you'll probably notice that
> performance of your 405ep board is the same in both cases (at least if
> in your tests you were _sending_ data from the 405ep).
>
> When computing "throughput" with small packet size don't forget to add
> L1/L2/L3 overhead (inter frame gap, Ethernet frame headers, IP and UDP
> headers), in case of UDP total overhead per packet is 66 bytes of
> Ethernet bandwidth;
>
> To demonstrate this point, consider the following (generated) table:
>
> UDP min size - 18, max size - 1472, overhead 66
>   20, rate 145348
>  120, rate  67204
>  220, rate  43706
>  320, rate  32383
>  420, rate  25720
>  520, rate  21331
>  620, rate  18221
>  720, rate  15903
>  820, rate  14108
>  920, rate  12677
> 1020, rate  11510
> 1120, rate  10539
> 1220, rate   9720
> 1320, rate   9018
> 1420, rate   8411
>
> First column - is the size of UDP payload, "rate" is the theoretical
> maximum number of packets you can fit in 100Mb link.
>
> Let's say you box is fast enough to send 10K packets per second. As
> you see it's more than enough to saturate 100Mb Ethernet with big
> packets (UDP payload > ~1120 bytes).
>
> But with 200-sized UDP payload you can only fill ~2.7% of 100Mb link.
>
> Also, please note, that usually you can _send_ more packets than
> receive and if you flood the box with a lot of packets you can
> experience so called "congestion collapse" (google "Beyond Softnet"
> for more details). This can be solved by modifing ethernet driver to
> use NAPI (some work is in progress for 4xx).
>
> Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
