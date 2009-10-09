Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1255084379-12954-1-git-send-email-w.sang@pengutronix.de>
References: <1255084379-12954-1-git-send-email-w.sang@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 9 Oct 2009 09:46:58 -0600
Message-ID: <fa686aa40910090846u38cc3463j4f5d934aa412763f@mail.gmail.com>
Subject: Re: [RFC] scripts/get_maintainer: add emails based on keywords in the
	patch
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Joe Perches <joe@perches.com>, linuxppc-dev@ozlabs.org,
	devicetree-discuss@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 9, 2009 at 4:32 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> Make get_maintainer.pl scan the modifying lines of a patch for a list of
> keywords and add an associated email if found. The first user is the
> devicetree-discuss mailing list which should always be cc'ed if a device =
tree
> property is inserted/removed (keyword 'of_get_property'). This patch is t=
he
> result from commit 1965d30356c1c65660ba3330927671cfe81acdd5 entering main=
line
> which seems to have been missed by all parties interested in the device t=
ree
> (and at least had the documentation missing). As adding properties can ha=
ppen
> anywhere and so there is no fitting fileglob, this keyword based approach=
 is
> proposed.

Nice.  I cannot comment on the implementation, but I like the approach.

g.

> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Joe Perches <joe@perches.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> =A0scripts/get_maintainer.pl | =A0 24 ++++++++++++++++--------
> =A01 files changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index cdb44b6..e1150ea 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -44,6 +44,11 @@ my $help =3D 0;
>
> =A0my $exit =3D 0;
>
> +my %keywords_to_mail =3D (
> + =A0 =A0 =A0 'of_get_property' =3D> 'L: devicetree-discuss@lists.ozlabs.=
org',
> +);
> +my $keywords_to_mail_match =3D join('|', keys %keywords_to_mail);
> +
> =A0my @penguin_chief =3D ();
> =A0push(@penguin_chief,"Linus Torvalds:torvalds\@linux-foundation.org");
> =A0#Andrew wants in on most everything - 2009/01/14
> @@ -188,6 +193,12 @@ if ($email_remove_duplicates) {
>
> =A0my @files =3D ();
> =A0my @range =3D ();
> +my @email_to =3D ();
> +my @list_to =3D ();
> +my @scm =3D ();
> +my @web =3D ();
> +my @subsystem =3D ();
> +my @status =3D ();
>
> =A0foreach my $file (@ARGV) {
> =A0 =A0 ##if $file is a directory and it lacks a trailing slash, add one
> @@ -213,7 +224,11 @@ foreach my $file (@ARGV) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ($email_git_blame) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0push(@range, "$lastfile:$1:$2");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 # Check the lines which a patch modifies for keywor=
ds; add mail if found.
> + =A0 =A0 =A0 =A0 =A0 } elsif (m/^[+-].*($keywords_to_mail_match)/o) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (my $keyword_mail =3D $keywords_to_mail{$1}=
) =3D~ s/^([LM]): //;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 push( @{ ($1 eq 'L') ? \@list_to : \@email_=
to }, $keyword_mail );
> + =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0close(PATCH);
> =A0 =A0 =A0 =A0if ($file_cnt =3D=3D @files) {
> @@ -224,13 +239,6 @@ foreach my $file (@ARGV) {
> =A0 =A0 }
> =A0}
>
> -my @email_to =3D ();
> -my @list_to =3D ();
> -my @scm =3D ();
> -my @web =3D ();
> -my @subsystem =3D ();
> -my @status =3D ();
> -
> =A0# Find responsible parties
>
> =A0foreach my $file (@files) {
> --
> 1.6.3.3
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
