Return-Path: <glikely@gmail.com>
Message-ID: <528646bc0609250000o1949a253n81f58ba994438ccd@mail.gmail.com>
Date: Mon, 25 Sep 2006 01:00:58 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Andersson Tord" <Tord.Andersson@combitech.se>
Subject: Re: Lite5200 NFS mount issue
In-Reply-To: <18CE82D3EF6EA84F9A1A79D6051A090028500C@CORPAPPL020.corp.saab.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <18CE82D3EF6EA84F9A1A79D6051A090028500C@CORPAPPL020.corp.saab.se>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/21/06, Andersson Tord <Tord.Andersson@combitech.se> wrote:
> Hi,
>
> I have some additional information on the problems we had with NFS on the Lite5200 card and the
> 2.4.25 kernel (DENX linuxppc_2_4_devel 2006-04-06) .
> When analyzing the IP traffic with Etherreal, it was seen that the problems were
> caused by loss of fragmented IP-packets. When the IP fragmentation was removed by forcing NFS's
> UDP size to less than the Ethernet MTU size, the problems disappeared.
> We used the kernel NFS argument option to this effect;
>
>         nfsroot=${serverip}:${rootpath},rsize=1024,wsize=1024

After having similar problems, I've had good luck by forcing nfs to
use tcp by appending ',tcp' to the nfsroot= argument.

g.


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
