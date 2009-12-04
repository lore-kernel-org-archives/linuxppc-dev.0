Return-Path: <ml.lawnick@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D15EEB6EF6
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 17:58:24 +1100 (EST)
Message-ID: <4B18B30B.1080904@gmx.de>
Date: Fri, 04 Dec 2009 07:58:19 +0100
From: Michael Lawnick <ml.lawnick@gmx.de>
MIME-Version: 1.0
To: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused
	by read i2c_msg
References: <4A124202.4010201@doredevelopment.dk>
	<d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
	<20090526213351.GG23114@fluff.org.uk> <4B17D4C5.3070100@gmx.de>
	<20091203152916.GC23152@trinity.fluff.org>
In-Reply-To: <20091203152916.GC23152@trinity.fluff.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Esben Haabendal <eha@doredevelopment.dk>,
	Esben Haabendal <esbenhaabendal@gmail.com>, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben Dooks said the following:
> On Thu, Dec 03, 2009 at 04:09:57PM +0100, Michael Lawnick wrote:
>> Ben Dooks said the following:
>> > On Tue, May 26, 2009 at 01:30:21PM +0200, Esben Haabendal wrote:
>> >> On Tue, May 19, 2009 at 7:22 AM, Esben Haabendal <eha@doredevelopment.dk> wrote:
>> >> > This fixes MAL (arbitration lost) bug caused by illegal use of
>> >> > RSTA (repeated START) after STOP condition generated after last byte
>> >> > of reads. With this patch, it is possible to do an i2c_transfer() with
>> >> > additional i2c_msg's following the I2C_M_RD messages.
>> >> >
>> >> > It still needs to be resolved if it is possible to fix this issue
>> >> > by removing the STOP condition after reads in a robust way.
>> >> >
>> >> > Signed-off-by: Esben Haabendal <eha@doredevelopment.dk>
>> >> > ---
>> >> > ?drivers/i2c/busses/i2c-mpc.c | ? ?9 +++++++--
>> >> > ?1 files changed, 7 insertions(+), 2 deletions(-)
>> >> 
>> >> Any blockers to get this accepted?
>> > 
>> > It would be nice to get an ack from someone who can actually test
>> > the driver before getting this merged.
>> >  
>> What is the state of this patch?
>> Shouldn't we attack the problem on a more general way by inventing a
>> Flag I2C_M_RESTART (or better I2C_M_NO_RESTART for backward compatibility)?
>> This way the client driver is able to decide what it needs. If we do the
>> choice within adapter, chance is about 50% to be wrong.
> 
> The documentation for 'struct i2c_msg' already says the STOP should only
> be generated for the last message of the transfer. If STOP is being
> generated for a message that isn't the last in the transfer than this
> is incorrect behaviour.

Ah, now I see, this is a mpc-only problem of implementation
(automatically generating stop in read function).
I couldn't find the above mentioned specification of STOP/RESTART (seems
I need new glasses) and was worried about whether my own implementation
for OCTEON is correct.

Thank you.
-- 
Michael
