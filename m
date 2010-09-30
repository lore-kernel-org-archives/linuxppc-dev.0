Return-Path: <christian@riesch.at>
Message-ID: <20100930055058.51095mqjao91pe88@webmail.df.eu>
Date: Thu, 30 Sep 2010 05:50:58 +0200
From: Christian Riesch <christian@riesch.at>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<alpine.DEB.2.00.1009231238170.2962@router.home>
	<1285268380.2587.11.camel@localhost.localdomain>
	<alpine.DEB.2.00.1009231402420.2962@router.home>
	<1285273684.2587.92.camel@localhost.localdomain>
	<alpine.DEB.2.00.1009231533040.7522@router.home>
	<20100923223417.4ed62e5b@lxorguk.ukuu.org.uk>
	<4C9BC7CE.8020400@riesch.at>
	<alpine.DEB.2.00.1009271035110.9258@router.home>
In-Reply-To: <alpine.DEB.2.00.1009271035110.9258@router.home>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 DelSp="Yes";
 format="flowed"
Cc: Rodolfo Giometti <giometti@linux.it>, Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, john stultz <johnstul@us.ibm.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-api@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org, Richard Cochran <richardcochran@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Christoph Lameter <cl@linux.com>:
> On Thu, 23 Sep 2010, Christian Riesch wrote:
>
>> > > It implies clock tuning in userspace for a potential sub microsecond
>> > > accurate clock. The clock accuracy will be limited by user space
>> > > latencies and noise. You wont be able to discipline the system clock
>> > > accurately.
>> >
>> > Noise matters, latency doesn't.
>>
>> Well put! That's why we need hardware support for PTP timestamping to reduce
>> the noise, but get along well with the clock servo that is steering  
>> the PHC in
>> user space.
>
> Even if I buy into the catch phrase above: User space is subject to noise
> that the in kernel code is not. If you do the tuning over long intervals
> then it hopefully averages out but it still causes jitter effects that
> affects the degree of accuracy (or sync) that you can reach. And the noise
> varies with the load on the system.

Yes and no. If you regard it as a control system: The latencies of the  
operating system are a dead time in the control system. The sampling  
time is quite large, one second, maybe around 100ms or 10ms in  
telecommunication applications, but that is still large compared to  
the latencies you expect to have in the operating system. Hence, this  
latencies (=dead time) can be neglected and the important thing that  
remains is the noise that you introduce in the measurements of the  
time stamps, which is therefore done in hardware.
I admit that my short statement above is not completely correct, I  
should have mentioned the rather large sampling time we are dealing  
with here.

Christian
