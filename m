Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Message-ID: <44B4FDF2.6010602@smiths-aerospace.com>
Date: Wed, 12 Jul 2006 09:49:38 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Zhou Rui <vancasperz@yahoo.com.cn>
Subject: Re: Problems of Compiling Kernel with linux-2.4.27 and linux-2.6.17
	for	PowerPC405EP Board
References: <20060712130102.40670.qmail@web15604.mail.cnb.yahoo.com>
In-Reply-To: <20060712130102.40670.qmail@web15604.mail.cnb.yahoo.com>
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-dev@ozlabs.org, der.herr@hofr.at, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Zhou Rui wrote:
> Hi,
> Yesterday I tried to compile kernel with linux-2.4.27 and linux-2.6.17 
> for PowerPC405EP board. Both of the kernel images were created 
> successfully, but when I tested them in ram from u-boot with NFS used. 
> Both of the images could not booted from ram. The two kernel .config 
> files are attached.
> 
> For the 2.4.27 kernel, after running bootm in u-boot and "Uncompressing 
> Kernel Image ... OK" printed on the screen. There are
> "vector: 200 at pc = c0197d4c, lr = c0197d40
> msr = 1030, sp = c0181fb0 [c0181f00]
> current = c0180020, pid = 0, comm = swapper
> mon>".
> It seemd the booting process had entered a monitor, but I didn't know 
> what it was.
> 
> For the 2.6.17 kernel, after running bootm in u-boot, the booting 
> process stops at "Uncompressing Kernel Image ... OK". No other output 
> after this sentence on the screen.
> 
> Would you like to give some advice about this? Thanks a lot.
> 
> Zhou Rui
> Distributed & Embedded System Lab
> School of Information Science & Engineering
> Lanzhou University, P. R. China
> http://dslab.lzu.edu.cn/~zr/

Exception 200 is "Machine Check".  If you are getting this on linux
start up it is usually due to a double bus fault which is usually due to
a memory map problem.  Silent boot failures are also often caused by
memory map problems... switching from physical memory mapping to virtual
(turning on the MMU).

gvb
