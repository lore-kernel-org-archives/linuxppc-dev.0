Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100831161644.GA14505@albatros>
References: <1283075566-27441-1-git-send-email-julia@diku.dk>
	<1283075566-27441-2-git-send-email-julia@diku.dk>
	<4C7D247F.4060500@bfs.de>
	<Pine.LNX.4.64.1008311807470.2668@ask.diku.dk>
	<20100831161644.GA14505@albatros>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 31 Aug 2010 10:33:52 -0600
Message-ID: <AANLkTi=3b0NY5pFepv-TmjFDmPUBK9Ew16HyTn-+YguX@mail.gmail.com>
Subject: Re: [PATCH 1/7] drivers/macintosh/via-pmu-led.c: Add of_node_put to
	avoid memory leak
To: Vasiliy Kulikov <segooon@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, Julia Lawall <julia@diku.dk>,
	linuxppc-dev@lists.ozlabs.org, walter harms <wharms@bfs.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 31, 2010 at 10:16 AM, Vasiliy Kulikov <segooon@gmail.com> wrote=
:
> On Tue, Aug 31, 2010 at 18:08 +0200, Julia Lawall wrote:
>> On Tue, 31 Aug 2010, walter harms wrote:
>> > > =A0 if (strncmp(model, "PowerBook", strlen("PowerBook")) !=3D 0 &&
>> > > =A0 =A0 =A0 strncmp(model, "iBook", strlen("iBook")) !=3D 0 &&
>> > > =A0 =A0 =A0 strcmp(model, "PowerMac7,2") !=3D 0 &&
>> > >
>> >
>> > is there any rule that says when to use strncmp ? it seems perfecly va=
lid to use strcpy here
>> > (what is done in the last cmp).
>>
>> Perhaps there are some characters after eg PowerBook that one doesn't wa=
nt
>> to compare with?
>
> It seems to me that model has no '\0' in the end. If model is got from
> the hardware then we should double check it - maybe harware is buggy.
> Otherwise we'll overflow model.

Model does have \0 at the end.  This code is using strncmp to
purposefully ignore the model suffix.

> But why strcmp(model, "PowerMac7,2")? IMO it should be replaced
> with strncmp().

We use strcmp when parsing the device tree because the the length of
the model property string is unknown and in most cases we *must* match
the exact entire string, such as with this PowerMac7,2 example.  Using
strncmp would also happen to match with something like
"PowerMac7,2345" which is not the desired behaviour.

g.
