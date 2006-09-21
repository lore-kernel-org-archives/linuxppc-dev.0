Return-Path: <edjubenville@adelphia.net>
From: "Edward Jubenville" <edjubenville@adelphia.net>
To: "Andersson Tord " <Tord.Andersson@combitech.se>,
	<Linuxppc-embedded@ozlabs.org>
Subject: RE: Lite5200 NFS mount issue
Date: Thu, 21 Sep 2006 09:43:50 -0700
Message-ID: <GPECLCIGPLHEOMGPMCPAKEBGEAAA.edjubenville@adelphia.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <18CE82D3EF6EA84F9A1A79D6051A090028500C@CORPAPPL020.corp.saab.se>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Tord Andersson wrote:
> When analyzing the IP traffic with Etherreal, it was seen that
> the problems were caused by loss of fragmented IP-packets. When
> the IP fragmentation was removed by forcing NFS's UDP size to
> less than the Ethernet MTU size, the problems disappeared.
> We used the kernel NFS argument option to this effect;
> 	nfsroot=${serverip}:${rootpath},rsize=1024,wsize=1024

You may not be having a board problem or a kernel problem.  I had exactly
the same problem with an almost identical configuration as you.  Using
Etherreal at various points in my network, I found that an Ethernet switch
in the communication path was dropping packets before the board ever saw
them.  I solved it the same way that you did (with rsize/wsize), and it has
worked fine ever since.

See my post on 7/26/2006, subject "Re: Slow boot with NFS, server not
responding".

Ed Jubenville
