Return-Path: <benh@kernel.crashing.org>
Subject: Re: vmsplice bad address
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
In-Reply-To: <201103031401.55649.dargaud@lpsc.in2p3.fr>
References: <201103031401.55649.dargaud@lpsc.in2p3.fr>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Mar 2011 20:35:44 +1100
Message-ID: <1299490544.9759.3.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-03-03 at 14:01 +0100, Guillaume Dargaud wrote:
> Hello all,
> I'm trying to use the vmsplice/splice combination to so socket writes in zero-copy mode since it seems to be the big 
> bottle neck in my application.
> 
> Here's a simplified code:
> 
> // This buffer is actually outside kernel space,
> // in reserved contiguous physical memory (custom kernel compilation)
> #define BUFFER_PHY_BASE 0x7000000
> #define BUFFER_SIZE 0x1000000
> memfd=open("/dev/mem", O_RDWR | O_SYNC)
> Base=(unsigned char*)mmap(0, BUFFER_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, memfd, BUFFER_PHY_BASE);
> 
> sockfd = socket(AF_INET, SOCK_STREAM, 0)
> 
> int pfd[2];	pipe(pfd);
> 
> struct iovec iov;
> iov.iov_base=Base;
> iov.iov_len=BUFFER_SIZE;
> printf("Pipe %d/%d, base:0x%x, size:0x%x\n", pfd[0], pfd[1], iov.iov_base, iov.iov_len);
> vmsplice(pfd[1], &iov, 1, SPLICE_F_GIFT)
> splice(pfd[0], NULL, sockfd, NULL, BUFFER_SIZE, SPLICE_F_MOVE)
> 
> I get the following:
> Pipe 6/7, base:0x480cf000, size:0x1000000
> vmsplice: Bad address
> 
> 
> Any idea what is wrong in my use of vmsplice ?

I'm not completely surprised ... I wouldn't expect vmsplice to work
on /dev/mem ... No struct page backing the memory for example.

Ben.
