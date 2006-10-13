Return-Path: <haren@us.ibm.com>
Message-ID: <452F03AB.7030505@us.ibm.com>
Date: Thu, 12 Oct 2006 20:10:35 -0700
From: Haren Myneni <haren@us.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] Add support for stopping spus from xmon
References: <20061012120310.6B5A967BD5@ozlabs.org>
In-Reply-To: <20061012120310.6B5A967BD5@ozlabs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:

>This patch adds support for stopping, and restarting, spus
>from xmon. We use the spu master runcntl bit to stop execution,
>this is apparently the "right" way to control spu execution and
>spufs will be changed in the future to use this bit.
>
>Testing has shown that to restart execution we have to turn the
>master runcntl bit on and also rewrite the spu runcntl bit, even
>if it is already set to 1 (running).
>
>Stopping spus is triggered by the xmon command 'ss' - "spus stop"
>perhaps. Restarting them is triggered via 'sr'. Restart doesn't
>start execution on spus unless they were running prior to being
>stopped by xmon.
>
>Walking the spu->full_list in xmon after a panic, would mean
>corruption of any spu struct would make all the others
>inaccessible. To avoid this, and also to make the next patch
>easier, we cache pointers to all spus during boot.
>
>We attempt to catch and recover from errors while stopping and
>restarting the spus, but as with most xmon functionality there are
>no guarantees that performing these operations won't crash xmon
>itself.
>
>  
>
I think, kdump also need stop_spus() functionality when the dump support 
is included on cell. If so, how about both stop_spus() and start_spus() 
in platforms/cell/.

Thanks
Haren
